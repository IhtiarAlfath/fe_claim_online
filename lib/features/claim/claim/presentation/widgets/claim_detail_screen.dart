import 'package:claim_online/core/utils/function.dart';
import 'package:claim_online/features/claim/claim/presentation/bloc/claim/claim_bloc.dart';
import 'package:claim_online/features/claim/claim/presentation/widgets/approval_confirm_dialog.dart';
import 'package:claim_online/features/claim/claim/presentation/widgets/edit_claim_dialog.dart';
import 'package:claim_online/features/claim/claim/presentation/widgets/upload_document.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:claim_online/features/claim/claim/domain/entities/data_claim.dart';
import '../widgets/claim_file_tile.dart';

class ClaimDetailScreen extends StatelessWidget {
  final DataClaim claim;
  const ClaimDetailScreen({super.key, required this.claim});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<ClaimBloc>()
          .add(ClaimEventGetClaimByClaimId(claimId: claim.claimId));
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Claim #${claim.claimId}'),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 1,
      ),
      backgroundColor: Colors.grey[50],
      body: MultiBlocListener(
        listeners: [
          BlocListener<ClaimBloc, ClaimState>(
            listenWhen: (previous, current) =>
                current is ClaimStateAddClaimDocument ||
                current is ClaimStateUpdateClaim ||
                current is ClaimStateUpdateClaimStatus ||
                current is ClaimStateDeleteClaimDocument,
            listener: (context, state) {
              if (state is ClaimStateAddClaimDocument) {
                showPopupNotification(context, 'Upload document success');

                context
                    .read<ClaimBloc>()
                    .add(ClaimEventGetClaimByClaimId(claimId: claim.claimId));
              } else if (state is ClaimStateDeleteClaimDocument) {
                showPopupNotification(context, 'Delete document success');

                context
                    .read<ClaimBloc>()
                    .add(ClaimEventGetClaimByClaimId(claimId: claim.claimId));
              } else if (state is ClaimStateUpdateClaim) {
                showPopupNotification(context, 'Claim submitted successfully!');
                context
                    .read<ClaimBloc>()
                    .add(ClaimEventGetClaimByClaimId(claimId: claim.claimId));
              } else if (state is ClaimStateUpdateClaimStatus) {
                showPopupNotification(
                    context, 'Claim status updated successfully!');
                context
                    .read<ClaimBloc>()
                    .add(ClaimEventGetClaimByClaimId(claimId: claim.claimId));
              }
            },
          ),
        ],
        child: BlocBuilder<ClaimBloc, ClaimState>(
          buildWhen: (prev, curr) =>
              curr is ClaimStateGetClaimByClaimId ||
              curr is ClaimStateLoading ||
              curr is ClaimStateError,
          builder: (context, state) {
            if (state is ClaimStateLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ClaimStateError) {
              return Center(child: Text(state.message));
            }

            if (state is ClaimStateGetClaimByClaimId) {
              final currentClaim = state.claim;
              return _buildClaimContent(context, currentClaim);
            }

            return _buildClaimContent(context, claim);
          },
        ),
      ),
    );
  }

  Widget _buildClaimContent(BuildContext context, DataClaim claim) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildClaimInfo(context, claim),
          const Gap(20),
          Row(
            children: [
              const Text(
                'Claim Document',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              IconButton(
                onPressed: () => addDocument(context, (files) async {
                  context.read<ClaimBloc>().add(
                        ClaimEventAddClaimDocument(
                          claimId: claim.claimId,
                          request: files,
                        ),
                      );
                }),
                icon: const Icon(Icons.add, color: Colors.blue, size: 28),
              ),
            ],
          ),
          const Gap(12),
          if (claim.files.isEmpty)
            const Text("You don't have any document yet")
          else
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: claim.files.length,
              itemBuilder: (context, index) {
                final file = claim.files[index];
                return ClaimFileTile(
                  file: file,
                  isCanDelete: claim.files.length > 2,
                );
              },
            ),
          const Gap(24),
          userRole == 2
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () => approvalConfirmDialog(
                        context,
                        title: 'Approve Claim',
                        message: 'Are you sure you want to approve this claim?',
                        confirmColor: Colors.green,
                        onConfirm: () {
                          context.read<ClaimBloc>().add(
                              ClaimEventUpdateClaimStatus(
                                  claimId: claim.claimId, statusId: 2));
                          Navigator.pop(context);
                        },
                      ),
                      icon: const Icon(Icons.check_circle_outline),
                      label: const Text('Approve'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(140, 45),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () => approvalConfirmDialog(
                        context,
                        title: 'Reject Claim',
                        message: 'Are you sure you want to reject this claim?',
                        confirmColor: Colors.red,
                        onConfirm: () {
                          context.read<ClaimBloc>().add(
                              ClaimEventUpdateClaimStatus(
                                  claimId: claim.claimId, statusId: 3));
                          Navigator.pop(context);
                        },
                      ),
                      icon: const Icon(Icons.cancel_outlined),
                      label: const Text('Reject'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(140, 45),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }

  Widget _buildClaimInfo(BuildContext context, DataClaim claim) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  claim.category,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Gap(6),
                Text(
                  'Status: ${claim.status}',
                  style: TextStyle(
                    fontSize: 15,
                    color: _getStatusColor(claim.status),
                  ),
                ),
                const Gap(4),
                Text(
                  'User: ${claim.userId}',
                  style: const TextStyle(fontSize: 13, color: Colors.grey),
                ),
                const Gap(4),
                const Text(
                  'Description:',
                  style: TextStyle(fontSize: 15),
                ),
                Text(
                  claim.claimDesc,
                  style: const TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
          userRole == 2
              ? Positioned(
                  top: 0,
                  right: 0,
                  child: IconButton(
                    icon: const Icon(Icons.edit_outlined,
                        color: Colors.blueAccent),
                    tooltip: 'Edit Claim',
                    onPressed: () => showEditClaimDialog(context, claim),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return Colors.green;
      case 'rejected':
        return Colors.red;
      case 'pending':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}

import 'package:claim_online/core/utils/auth_service.dart';
import 'package:claim_online/core/utils/function.dart';
import 'package:claim_online/features/authentication/domain/entities/data_user_token.dart';
import 'package:claim_online/features/claim/claim/presentation/bloc/claim_general/claim_general_bloc.dart';
import 'package:claim_online/features/claim/claim/presentation/widgets/add_claim_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:claim_online/features/claim/claim/domain/entities/data_claim.dart';
import 'package:claim_online/features/claim/claim/presentation/bloc/claim/claim_bloc.dart';
import 'package:claim_online/core/utils/constant.dart';

class ClaimScreen extends StatelessWidget {
  ClaimScreen({super.key});

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Claims'),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 1,
      ),
      backgroundColor: Colors.grey[50],
      floatingActionButton: FloatingActionButton(
        onPressed: () => onAddClaim(context),
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: BlocBuilder<ClaimBloc, ClaimState>(
        builder: (context, state) {
          if (state is ClaimStateLoading) {
            return const Center(
                child: CircularProgressIndicator(color: primaryColor));
          } else if (state is ClaimStateGetAllClaim ||
              state is ClaimStateGetClaimByUserId ||
              state is ClaimStateSearchClaim) {
            final claims = (state as dynamic).claim as List<DataClaim>;

            if (claims.isEmpty) {
              return const Center(child: Text('No claims found.'));
            }

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: searchController,
                    onChanged: (value) => _searchClaim(value, claims, context),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText: 'Search claims...',
                      filled: true,
                      fillColor: const Color.fromARGB(255, 234, 229, 229),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: claims.length,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemBuilder: (context, index) {
                      final claim = claims[index];
                      return _ClaimCard(
                        claim: claim,
                        ontTap: () => _openClaimDetail(context, claim),
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (state is ClaimStateAddClaim) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showPopupNotification(context, state.message);
              context.read<ClaimBloc>().add(const ClaimEventGetClaimByUserId());
            });
            return const SizedBox();
          } else if (state is ClaimStateEmpty) {
            return const Center(child: Text('No claims found.'));
          } else if (state is ClaimStateError) {
            return Center(child: Text(state.message));
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  void onAddClaim(BuildContext context) async {
    DataUserToken? userData = await AuthService.getUser();
    showAddClaimDialog(
      context,
      userId: userData!.userId,
      onSubmit: (request) async {
        context.read<ClaimBloc>().add(ClaimEventAddClaim(request: request));
      },
    );
  }

  void _openClaimDetail(BuildContext context, DataClaim claim) {
    context
        .read<ClaimGeneralBloc>()
        .add(ClaimGeneralEventClaimDetail(dataClaim: claim));
  }

  void _searchClaim(
      String text, List<DataClaim> myClaims, BuildContext context) {
    final results = myClaims
        .where((claim) =>
            claim.category.toLowerCase().contains(text.toLowerCase()) ||
            claim.status.toLowerCase().contains(text.toLowerCase()))
        .toList();

    context.read<ClaimBloc>().add(
          ClaimEventSearchClaim(inputSearch: text, claim: results),
        );
  }
}

class _ClaimCard extends StatelessWidget {
  final DataClaim claim;
  final VoidCallback ontTap;

  const _ClaimCard({
    required this.claim,
    required this.ontTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = _getStatusColor(claim.status);
    return InkWell(
      onTap: ontTap,
      child: Card(
        margin: const EdgeInsets.only(bottom: 12),
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.assignment, size: 36, color: color),
              const Gap(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      claim.category,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const Gap(4),
                    Text(
                      claim.claimDesc,
                    ),
                    const Gap(4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Status: ${claim.status}',
                          style: TextStyle(color: color),
                        ),
                        Text(
                          'Created by: ${claim.userId}',
                        ),
                      ],
                    ),
                    const Gap(4),
                  ],
                ),
              ),
            ],
          ),
        ),
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

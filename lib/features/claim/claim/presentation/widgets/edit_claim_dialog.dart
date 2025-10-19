import 'package:claim_online/features/claim/claim/domain/entities/data_claim.dart';
import 'package:claim_online/features/claim/claim_category/domain/entities/data_claim_category.dart';
import 'package:claim_online/features/claim/claim_category/presentation/bloc/claim_category_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:claim_online/features/claim/claim/domain/entities/data_claim_update_request.dart';
import 'package:claim_online/features/claim/claim/presentation/bloc/claim/claim_bloc.dart';

Future<void> showEditClaimDialog(BuildContext context, DataClaim claim) async {
  final TextEditingController descController =
      TextEditingController(text: claim.claimDesc);

  DataClaimCategory? selectedCategoryId;
  List<DataClaimCategory> claimCategory = [];

  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Dialog(
            insetPadding: const EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Icon(Icons.edit_note_rounded,
                        size: 50, color: Colors.blueAccent),
                  ),
                  const SizedBox(height: 8),
                  const Center(
                    child: Text(
                      'Edit Claim',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Dropdown Category
                  const Text('Category',
                      style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  BlocBuilder<ClaimCategoryBloc, ClaimCategoryState>(
                    bloc: context.read<ClaimCategoryBloc>()
                      ..add(const ClaimCategoryEventGetAllClaimCategory()),
                    builder: (context, state) {
                      if (state is ClaimCategoryStateGetAllClaimCategory) {
                        claimCategory = state.claimCategory
                            .map((e) => DataClaimCategory(
                                  claimCategoryId: e.claimCategoryId,
                                  claimCategoryName: e.claimCategoryName,
                                ))
                            .toList();

                        selectedCategoryId = claimCategory.firstWhere(
                          (element) =>
                              element.claimCategoryName == claim.category,
                          orElse: () => const DataClaimCategory(
                            claimCategoryId: '',
                            claimCategoryName: '',
                          ),
                        );
                      }

                      return DropdownButtonFormField<DataClaimCategory>(
                        value: selectedCategoryId,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[100],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 14),
                        ),
                        dropdownColor: Colors.white,
                        hint: Text(claim.category),
                        items: claimCategory.map((cat) {
                          return DropdownMenuItem<DataClaimCategory>(
                            value: cat,
                            child: Text(cat.claimCategoryName),
                          );
                        }).toList(),
                        onChanged: (val) => setState(() {
                          selectedCategoryId = val;
                        }),
                      );
                    },
                  ),
                  const SizedBox(height: 20),

                  const Text('Description',
                      style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  TextField(
                    controller: descController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[100],
                      hintText: 'Enter new description...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          if (selectedCategoryId == null &&
                              descController.text.trim().isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Please select a category or enter a description.'),
                                backgroundColor: Colors.redAccent,
                              ),
                            );
                            return;
                          }

                          final request = DataClaimUpdateRequest(
                            userId: claim.userId,
                            claimId: claim.claimId,
                            categoryId: selectedCategoryId!.claimCategoryId,
                            claimDesc: descController.text.trim(),
                          );

                          context.read<ClaimBloc>().add(
                                ClaimEventUpdateClaim(request: request),
                              );

                          Navigator.pop(context);
                        },
                        child: const Text('Submit'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

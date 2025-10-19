import 'dart:convert';
import 'package:claim_online/features/claim/claim_category/domain/entities/data_claim_category.dart';
import 'package:claim_online/features/claim/claim_category/presentation/bloc/claim_category_bloc.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:claim_online/features/claim/claim/domain/entities/data_claim_file_request.dart';
import 'package:claim_online/features/claim/claim/domain/entities/data_claim_request.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

Future<void> showAddClaimDialog(
  BuildContext context, {
  required String userId,
  required void Function(DataClaimRequest request) onSubmit,
}) async {
  final TextEditingController descController = TextEditingController();
  DataClaimCategory? selectedCategoryId;
  List<DataClaimFileRequest> selectedFiles = [];
  bool isUploading = false;
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
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.assignment_add,
                            color: Colors.blueAccent, size: 50),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Center(
                      child: Text(
                        'New Claim',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    const SizedBox(height: 20),

                    const Text('Category',
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    BlocBuilder<ClaimCategoryBloc, ClaimCategoryState>(
                      bloc: context.read<ClaimCategoryBloc>()
                        ..add(const ClaimCategoryEventGetAllClaimCategory()),
                      builder: (context, state) {
                        if (state is ClaimCategoryStateGetAllClaimCategory) {
                          claimCategory = state.claimCategory;
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
                          hint: const Text('Select category'),
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
                        hintText: "Enter claim description...",
                        filled: true,
                        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.all(14),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // File Upload
                    const Text('Attachments',
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    ElevatedButton.icon(
                      onPressed: isUploading
                          ? null
                          : () async {
                              final result =
                                  await FilePicker.platform.pickFiles(
                                allowMultiple: true,
                                withData: true,
                                type: FileType.any,
                              );

                              if (result != null && result.files.isNotEmpty) {
                                final files = result.files.map((file) {
                                  final base64Data = base64Encode(file.bytes!);
                                  final ext = file.extension ?? 'unknown';
                                  return DataClaimFileRequest(
                                    fileName: file.name,
                                    fileType: ext,
                                    fileData: base64Data,
                                  );
                                }).toList();

                                setState(() {
                                  for (var f in files) {
                                    if (!selectedFiles
                                        .any((e) => e.fileName == f.fileName)) {
                                      selectedFiles.add(f);
                                    }
                                  }
                                });
                              }
                            },
                      icon: const Icon(Icons.attach_file),
                      label: const Text("Choose Files"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    if (selectedFiles.isEmpty)
                      const Text(
                        'No files selected',
                        style: TextStyle(color: Colors.grey),
                      )
                    else
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxHeight: 150),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: selectedFiles.length,
                          itemBuilder: (context, index) {
                            final file = selectedFiles[index];
                            return Card(
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              color: Colors.grey[100],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: ListTile(
                                leading: const Icon(Icons.insert_drive_file,
                                    color: Colors.blueAccent),
                                title: Text(file.fileName,
                                    overflow: TextOverflow.ellipsis),
                                trailing: IconButton(
                                  icon: const Icon(Icons.close,
                                      color: Colors.redAccent),
                                  onPressed: () => setState(() {
                                    selectedFiles.removeAt(index);
                                  }),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    const Gap(24),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed:
                              isUploading ? null : () => Navigator.pop(context),
                          child: const Text('Cancel',
                              style: TextStyle(color: Colors.grey)),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton(
                          onPressed: (isUploading ||
                                  selectedCategoryId == null ||
                                  descController.text.isEmpty ||
                                  selectedFiles.length < 2)
                              ? null
                              : () async {
                                  setState(() => isUploading = true);

                                  final request = DataClaimRequest(
                                    userId: userId,
                                    categoryId:
                                        selectedCategoryId!.claimCategoryId,
                                    claimDesc: descController.text.trim(),
                                    files: selectedFiles,
                                  );

                                  onSubmit(request);
                                  setState(() => isUploading = false);
                                  Navigator.pop(context);
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: isUploading
                              ? const SizedBox(
                                  height: 16,
                                  width: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : const Text('Submit'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}

  import 'dart:convert';

import 'package:claim_online/features/claim/claim/domain/entities/data_claim_file_request.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
Future<void> addDocument(
  BuildContext context,
  Future<void> Function(List<DataClaimFileRequest> files) onSubmit,
) async {
  List<DataClaimFileRequest> selectedFiles = [];
  bool isUploading = false;

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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.cloud_upload_rounded,
                      size: 50, color: Colors.blueAccent),
                  const SizedBox(height: 12),
                  const Text(
                    'Add Claim Document',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Select one or more files to attach to your claim.',
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),

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
                                final base64Data =
                                    base64Encode(file.bytes!);
                                final ext = file.extension ?? 'unknown';
                                return DataClaimFileRequest(
                                  fileName: file.name,
                                  fileType: ext,
                                  fileData: base64Data,
                                );
                              }).toList();

                              setState(() {
                                for (var f in files) {
                                  if (!selectedFiles.any(
                                      (e) => e.fileName == f.fileName)) {
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
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  if (selectedFiles.isEmpty)
                    const Column(
                      children: [
                        Icon(Icons.folder_open,
                            size: 40, color: Colors.grey),
                        SizedBox(height: 8),
                        Text(
                          'No files selected',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    )
                  else
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxHeight: 200),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: selectedFiles.length,
                        itemBuilder: (context, index) {
                          final file = selectedFiles[index];
                          return Card(
                            elevation: 0,
                            margin: const EdgeInsets.only(bottom: 8),
                            color: Colors.grey[100],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ListTile(
                              leading: const Icon(Icons.insert_drive_file,
                                  color: Colors.blueAccent),
                              title: Text(
                                file.fileName,
                                style: const TextStyle(fontSize: 14),
                                overflow: TextOverflow.ellipsis,
                              ),
                              trailing: IconButton(
                                icon: const Icon(Icons.close,
                                    color: Colors.redAccent),
                                onPressed: isUploading
                                    ? null
                                    : () {
                                        setState(() =>
                                            selectedFiles.removeAt(index));
                                      },
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                  const SizedBox(height: 24),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: isUploading
                            ? null
                            : () => Navigator.pop(context),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton(
                        onPressed: selectedFiles.isEmpty || isUploading
                            ? null
                            : () async {
                                setState(() => isUploading = true);
                                await onSubmit(selectedFiles); // 🔥 Panggil callback luar
                                setState(() => isUploading = false);
                                Navigator.pop(context);
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
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
          );
        },
      );
    },
  );
}

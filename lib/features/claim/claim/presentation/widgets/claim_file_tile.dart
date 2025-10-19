import 'dart:convert';
import 'dart:typed_data';
import 'package:claim_online/core/utils/function.dart';
import 'package:claim_online/features/claim/claim/presentation/bloc/claim/claim_bloc.dart';
import 'package:flutter/material.dart';
import 'package:claim_online/features/claim/claim/domain/entities/data_claim_file.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClaimFileTile extends StatelessWidget {
  final DataClaimFile file;
  final bool isCanDelete;

  const ClaimFileTile(
      {super.key, required this.file, required this.isCanDelete});

  @override
  Widget build(BuildContext context) {
    final isImage =
        ['jpg', 'jpeg', 'png'].contains(file.fileType.toLowerCase());
    final fileBytes = file.fileData; // base64 string dari API

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Icon(
          isImage ? Icons.image_outlined : Icons.insert_drive_file_outlined,
          color: Colors.blueAccent,
          size: 32,
        ),
        title: Text(
          file.fileName,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          file.fileType.toUpperCase(),
          style: const TextStyle(color: Colors.grey, fontSize: 13),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // tombol open
            IconButton(
              tooltip: 'Open file',
              icon: const Icon(Icons.open_in_new, color: Colors.blueAccent),
              onPressed: () =>
                  _openFileDialog(context, file, isImage, fileBytes),
            ),
            // tombol delete
            IconButton(
              tooltip: 'Delete file',
              icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
              onPressed: () => _confirmDeleteDialog(context, file, isCanDelete),
            ),
          ],
        ),
        onTap: () => _openFileDialog(context, file, isImage, fileBytes),
      ),
    );
  }

  void _openFileDialog(
      BuildContext context, DataClaimFile file, bool isImage, String base64) {
    if (isImage) {
      final bytes = const Base64Decoder().convert(base64);
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => AnimatedOpacity(
          opacity: 1,
          duration: const Duration(milliseconds: 200),
          child: Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: const EdgeInsets.all(16),
            child: Stack(
              alignment: Alignment.center,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    color: Colors.black54,
                  ),
                ),
                InteractiveViewer(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.memory(
                      bytes,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Positioned(
                  top: 20,
                  right: 20,
                  child: IconButton(
                    icon:
                        const Icon(Icons.close, color: Colors.white, size: 28),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (_) => AnimatedOpacity(
          opacity: 1,
          duration: const Duration(milliseconds: 200),
          child: AlertDialog(
            title: Text(file.fileName),
            content: const Text(
                'File tidak dapat ditampilkan langsung (non-image).'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Tutup'),
              ),
            ],
          ),
        ),
      );
    }
  }

  void _confirmDeleteDialog(
      BuildContext context, DataClaimFile file, bool isCanDelete) {
    if (isCanDelete) {
      showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.redAccent,
                    size: 50,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Delete Document?',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Are you sure you want to delete "${file.fileName}"?',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.grey),
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
                      const SizedBox(width: 8),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.delete, size: 18),
                        label: const Text('Delete'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          context.read<ClaimBloc>().add(
                              ClaimEventDeleteClaimDocument(
                                  fileId: file.fileId));
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    } else {
      showPopupNotification(context,
          "At least 2 files are required. You can’t delete this file.");
    }
  }
}

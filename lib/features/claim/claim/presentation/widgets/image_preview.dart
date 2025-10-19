import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';

class ImagePreviewScreen extends StatelessWidget {
  final String fileName;
  final String base64Data;

  const ImagePreviewScreen({
    super.key,
    required this.fileName,
    required this.base64Data,
  });

  @override
  Widget build(BuildContext context) {
    final imageBytes = _decodeBase64(base64Data);

    return Scaffold(
      appBar: AppBar(
        title: Text(fileName),
      ),
      body: Center(
        child: Image.memory(imageBytes),
      ),
    );
  }

  Uint8List _decodeBase64(String base64String) {
    return const Base64Decoder().convert(base64String);
  }
}

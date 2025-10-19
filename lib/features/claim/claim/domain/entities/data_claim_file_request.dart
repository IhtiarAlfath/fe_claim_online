import 'package:equatable/equatable.dart';

class DataClaimFileRequest extends Equatable {
  final String fileName;
  final String fileType;
  final String fileData;

  const DataClaimFileRequest({
    required this.fileName,
    required this.fileType,
    required this.fileData,
  });
  @override
  List<Object?> get props => [
        fileName,
        fileType,
        fileData,
      ];
}

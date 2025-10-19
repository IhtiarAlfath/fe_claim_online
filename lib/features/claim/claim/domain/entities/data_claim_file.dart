import 'package:equatable/equatable.dart';

class DataClaimFile extends Equatable {
  final int fileId;
  final int claimId;
  final String fileName;
  final String fileType;
  final String fileData;

  const DataClaimFile({
    required this.fileId,
    required this.claimId,
    required this.fileName,
    required this.fileType,
    required this.fileData,
  });
  @override
  List<Object?> get props => [
    fileId,
    claimId,
    fileName,
    fileType,
    fileData,
      ];
}

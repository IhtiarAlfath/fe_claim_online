import 'package:equatable/equatable.dart';

class DataClaimCategory extends Equatable {
  final String claimCategoryId;
  final String claimCategoryName;

  const DataClaimCategory({
    required this.claimCategoryId,
    required this.claimCategoryName,
  });
  @override
  List<Object?> get props => [
        claimCategoryId,
        claimCategoryName,
      ];
}

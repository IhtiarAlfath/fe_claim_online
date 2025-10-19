part of 'claim_category_bloc.dart';

abstract class ClaimCategoryState extends Equatable {
  const ClaimCategoryState([List<dynamic> props = const <dynamic>[]]);
}

class ClaimCategoryStateEmpty extends ClaimCategoryState {
  @override
  List<Object?> get props => [];
}

class ClaimCategoryStateLoading extends ClaimCategoryState {
  @override
  List<Object?> get props => [];
}

class ClaimCategoryStateError extends ClaimCategoryState {
  final String message;

  const ClaimCategoryStateError({required this.message});
  @override
  List<Object?> get props => [message];
}

class ClaimCategoryStateGetAllClaimCategory extends ClaimCategoryState {
  final List<DataClaimCategory> claimCategory;

  const ClaimCategoryStateGetAllClaimCategory(
      {required this.claimCategory});
  @override
  List<Object?> get props => [claimCategory];
}

class ClaimCategoryStateSortClaimCategory extends ClaimCategoryState {
  final List<DataClaimCategory> claimCategory;
  final bool isAscending;
  final int sortIndex;

  const ClaimCategoryStateSortClaimCategory({
    required this.claimCategory,
    required this.isAscending,
    required this.sortIndex,
  });
  @override
  List<Object?> get props => [claimCategory, isAscending, sortIndex];
}

class ClaimCategoryStateSearchClaimCategory extends ClaimCategoryState {
  final String inputSearch;
  final List<DataClaimCategory> claimCategory;
  const ClaimCategoryStateSearchClaimCategory({
    required this.inputSearch,
    required this.claimCategory,
  });

  @override
  List<Object?> get props => [
        inputSearch,
        claimCategory,
      ];
}

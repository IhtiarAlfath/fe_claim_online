part of 'claim_category_bloc.dart';

abstract class ClaimCategoryEvent extends Equatable {
  const ClaimCategoryEvent([List<dynamic> props = const <dynamic>[]]);
}

class ClaimCategoryEventGetAllClaimCategory extends ClaimCategoryEvent {
  const ClaimCategoryEventGetAllClaimCategory();
  @override
  List<Object?> get props => [];
}

class ClaimCategoryEventSortClaimCategory extends ClaimCategoryEvent {
  final List<DataClaimCategory> claimCategory;
  final bool isAscending;
  final int sortIndex;
  const ClaimCategoryEventSortClaimCategory({
    required this.claimCategory,
    required this.isAscending,
    required this.sortIndex,
  });
  @override
  List<Object?> get props => [
        claimCategory,
        isAscending,
        sortIndex,
      ];
}

class ClaimCategoryEventSearchClaimCategory extends ClaimCategoryEvent {
  final String inputSearch;
  final List<DataClaimCategory> claimCategory;

  const ClaimCategoryEventSearchClaimCategory({
    required this.inputSearch,
    required this.claimCategory,
  });

  @override
  List<Object?> get props => [
        inputSearch,
        claimCategory,
      ];
}

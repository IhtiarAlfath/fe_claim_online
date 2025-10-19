part of 'claim_status_bloc.dart';

abstract class ClaimStatusState extends Equatable {
  const ClaimStatusState([List<dynamic> props = const <dynamic>[]]);
}

class ClaimStatusStateEmpty extends ClaimStatusState {
  @override
  List<Object?> get props => [];
}

class ClaimStatusStateLoading extends ClaimStatusState {
  @override
  List<Object?> get props => [];
}

class ClaimStatusStateError extends ClaimStatusState {
  final String message;

  const ClaimStatusStateError({required this.message});
  @override
  List<Object?> get props => [message];
}

class ClaimStatusStateGetAllClaimStatus extends ClaimStatusState {
  final List<DataClaimStatus> claimStatus;

  const ClaimStatusStateGetAllClaimStatus(
      {required this.claimStatus});
  @override
  List<Object?> get props => [claimStatus];
}

class ClaimStatusStateSortClaimStatus extends ClaimStatusState {
  final List<DataClaimStatus> claimStatus;
  final bool isAscending;
  final int sortIndex;

  const ClaimStatusStateSortClaimStatus({
    required this.claimStatus,
    required this.isAscending,
    required this.sortIndex,
  });
  @override
  List<Object?> get props => [claimStatus, isAscending, sortIndex];
}

class ClaimStatusStateSearchClaimStatus extends ClaimStatusState {
  final String inputSearch;
  final List<DataClaimStatus> claimStatus;
  const ClaimStatusStateSearchClaimStatus({
    required this.inputSearch,
    required this.claimStatus,
  });

  @override
  List<Object?> get props => [
        inputSearch,
        claimStatus,
      ];
}

part of 'claim_status_bloc.dart';

abstract class ClaimStatusEvent extends Equatable {
  const ClaimStatusEvent([List<dynamic> props = const <dynamic>[]]);
}

class ClaimStatusEventGetAllClaimStatus extends ClaimStatusEvent {
  const ClaimStatusEventGetAllClaimStatus();
  @override
  List<Object?> get props => [];
}

class ClaimStatusEventSortClaimStatus extends ClaimStatusEvent {
  final List<DataClaimStatus> claimStatus;
  final bool isAscending;
  final int sortIndex;
  const ClaimStatusEventSortClaimStatus({
    required this.claimStatus,
    required this.isAscending,
    required this.sortIndex,
  });
  @override
  List<Object?> get props => [
        claimStatus,
        isAscending,
        sortIndex,
      ];
}

class ClaimStatusEventSearchClaimStatus extends ClaimStatusEvent {
  final String inputSearch;
  final List<DataClaimStatus> claimStatus;

  const ClaimStatusEventSearchClaimStatus({
    required this.inputSearch,
    required this.claimStatus,
  });

  @override
  List<Object?> get props => [
        inputSearch,
        claimStatus,
      ];
}

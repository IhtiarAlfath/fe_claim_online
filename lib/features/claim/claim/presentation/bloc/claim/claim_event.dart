part of 'claim_bloc.dart';

abstract class ClaimEvent extends Equatable {
  const ClaimEvent([List<dynamic> props = const <dynamic>[]]);
}

class ClaimEventGetAllClaim extends ClaimEvent {
  const ClaimEventGetAllClaim();
  @override
  List<Object?> get props => [];
}

class ClaimEventGetClaimByUserId extends ClaimEvent {
  const ClaimEventGetClaimByUserId();
  @override
  List<Object?> get props => [];
}

class ClaimEventGetClaimByClaimId extends ClaimEvent {
  final int claimId;
  const ClaimEventGetClaimByClaimId({required this.claimId});
  @override
  List<Object?> get props => [claimId];
}

class ClaimEventDeleteClaimDocument extends ClaimEvent {
  final int fileId;
  const ClaimEventDeleteClaimDocument({required this.fileId});
  @override
  List<Object?> get props => [fileId];
}

class ClaimEventAddClaim extends ClaimEvent {
  final DataClaimRequest request;
  const ClaimEventAddClaim({required this.request});
  @override
  List<Object?> get props => [request];
}

class ClaimEventUpdateClaim extends ClaimEvent {
  final DataClaimUpdateRequest request;
  const ClaimEventUpdateClaim({required this.request});
  @override
  List<Object?> get props => [request];
}

class ClaimEventUpdateClaimStatus extends ClaimEvent {
  final int claimId;
  final int statusId;
  const ClaimEventUpdateClaimStatus({required this.claimId,required this.statusId});
  @override
  List<Object?> get props => [claimId, statusId];
}

class ClaimEventAddClaimDocument extends ClaimEvent {
  final int claimId;
  final List<DataClaimFileRequest> request;
  const ClaimEventAddClaimDocument({required this.claimId,required this.request});
  @override
  List<Object?> get props => [claimId, request];
}

class ClaimEventSortClaim extends ClaimEvent {
  final List<DataClaim> claim;
  final bool isAscending;
  final int sortIndex;
  const ClaimEventSortClaim({
    required this.claim,
    required this.isAscending,
    required this.sortIndex,
  });
  @override
  List<Object?> get props => [
        claim,
        isAscending,
        sortIndex,
      ];
}

class ClaimEventSearchClaim extends ClaimEvent {
  final String inputSearch;
  final List<DataClaim> claim;

  const ClaimEventSearchClaim({
    required this.inputSearch,
    required this.claim,
  });

  @override
  List<Object?> get props => [
        inputSearch,
        claim,
      ];
}

part of 'claim_bloc.dart';

abstract class ClaimState extends Equatable {
  const ClaimState([List<dynamic> props = const <dynamic>[]]);
}

class ClaimStateEmpty extends ClaimState {
  @override
  List<Object?> get props => [];
}

class ClaimStateLoading extends ClaimState {
  @override
  List<Object?> get props => [];
}

class ClaimStateError extends ClaimState {
  final String message;

  const ClaimStateError({required this.message});
  @override
  List<Object?> get props => [message];
}

class ClaimStateGetAllClaim extends ClaimState {
  final List<DataClaim> claim;

  const ClaimStateGetAllClaim(
      {required this.claim});
  @override
  List<Object?> get props => [claim];
}

class ClaimStateGetClaimByUserId extends ClaimState {
  final List<DataClaim> claim;

  const ClaimStateGetClaimByUserId(
      {required this.claim});
  @override
  List<Object?> get props => [claim];
}

class ClaimStateGetClaimByClaimId extends ClaimState {
  final DataClaim claim;

  const ClaimStateGetClaimByClaimId(
      {required this.claim});
  @override
  List<Object?> get props => [claim];
}

class ClaimStateAddClaim extends ClaimState {
  final String message;
  const ClaimStateAddClaim({required this.message});
  @override
  List<Object?> get props => [message];
}

class ClaimStateUpdateClaim extends ClaimState {
  final String message;
  const ClaimStateUpdateClaim({required this.message});
  @override
  List<Object?> get props => [message];
}

class ClaimStateUpdateClaimStatus extends ClaimState {
  final String message;
  const ClaimStateUpdateClaimStatus({required this.message});
  @override
  List<Object?> get props => [message];
}

class ClaimStateAddClaimDocument extends ClaimState {
  final String message;
  const ClaimStateAddClaimDocument({required this.message});
  @override
  List<Object?> get props => [message];
}

class ClaimStateDeleteClaimDocument extends ClaimState {
  final String message;
  const ClaimStateDeleteClaimDocument({required this.message});
  @override
  List<Object?> get props => [message];
}

class ClaimStateSortClaim extends ClaimState {
  final List<DataClaim> claim;
  final bool isAscending;
  final int sortIndex;

  const ClaimStateSortClaim({
    required this.claim,
    required this.isAscending,
    required this.sortIndex,
  });
  @override
  List<Object?> get props => [claim, isAscending, sortIndex];
}

class ClaimStateSearchClaim extends ClaimState {
  final String inputSearch;
  final List<DataClaim> claim;
  const ClaimStateSearchClaim({
    required this.inputSearch,
    required this.claim,
  });

  @override
  List<Object?> get props => [
        inputSearch,
        claim,
      ];
}

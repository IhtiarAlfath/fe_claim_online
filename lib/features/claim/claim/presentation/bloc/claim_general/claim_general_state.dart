part of 'claim_general_bloc.dart';

abstract class ClaimGeneralState extends Equatable {
  const ClaimGeneralState([List<dynamic> props = const <dynamic>[]]);
}

class ClaimGeneralStateEmpty extends ClaimGeneralState {
  @override
  List<Object?> get props => [];
}

class ClaimGeneralStateLoading extends ClaimGeneralState {
  @override
  List<Object?> get props => [];
}

class ClaimGeneralStateError extends ClaimGeneralState {
  final String message;

  const ClaimGeneralStateError({required this.message});
  @override
  List<Object?> get props => [message];
}

class ClaimGeneralStateClaimSummary extends ClaimGeneralState {
  const ClaimGeneralStateClaimSummary();
  @override
  List<Object?> get props => [];
}

class ClaimGeneralStateUserManagement extends ClaimGeneralState {
  const ClaimGeneralStateUserManagement();
  @override
  List<Object?> get props => [];
}

class ClaimGeneralStateClaimDetail extends ClaimGeneralState {
  final DataClaim dataClaim;
  const ClaimGeneralStateClaimDetail({required this.dataClaim});
  @override
  List<Object?> get props => [dataClaim];
}


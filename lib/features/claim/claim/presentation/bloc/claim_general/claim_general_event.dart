part of 'claim_general_bloc.dart';

abstract class ClaimGeneralEvent extends Equatable {
  const ClaimGeneralEvent([List<dynamic> props = const <dynamic>[]]);
}

class ClaimGeneralEventEmpty extends ClaimGeneralEvent {
  const ClaimGeneralEventEmpty();
  @override
  List<Object?> get props => [];
}

class ClaimGeneralEventGetClaimByUserId extends ClaimGeneralEvent {
  const ClaimGeneralEventGetClaimByUserId();
  @override
  List<Object?> get props => [];
}

class ClaimGeneralEventClaimSummary extends ClaimGeneralEvent {
  const ClaimGeneralEventClaimSummary();
  @override
  List<Object?> get props => [];
}

class ClaimGeneralEventClaimDetail extends ClaimGeneralEvent {
  final DataClaim dataClaim;
  const ClaimGeneralEventClaimDetail({required this.dataClaim});
  @override
  List<Object?> get props => [dataClaim];
}

class ClaimGeneralEventUserManagement extends ClaimGeneralEvent {
  final DataClaim dataClaim;
  const ClaimGeneralEventUserManagement({required this.dataClaim});
  @override
  List<Object?> get props => [dataClaim];
}

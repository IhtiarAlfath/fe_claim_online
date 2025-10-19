import 'package:bloc/bloc.dart';
import 'package:claim_online/features/claim/claim/domain/entities/data_claim.dart';
import 'package:equatable/equatable.dart';

part 'claim_general_event.dart';
part 'claim_general_state.dart';

class ClaimGeneralBloc extends Bloc<ClaimGeneralEvent, ClaimGeneralState> {
  ClaimGeneralBloc() : super(ClaimGeneralStateEmpty()) {
    on<ClaimGeneralEventEmpty>((event, emit) {
      emit(ClaimGeneralStateEmpty());
    });
    on<ClaimGeneralEventClaimSummary>((event, emit) {
      emit(const ClaimGeneralStateClaimSummary());
    });
    on<ClaimGeneralEventClaimDetail>((event, emit) {
      emit(ClaimGeneralStateClaimDetail(dataClaim: event.dataClaim));
    });
    on<ClaimGeneralEventUserManagement>((event, emit) {
      emit(const ClaimGeneralStateUserManagement());
    });
  }
}

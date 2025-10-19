import 'package:bloc/bloc.dart';
import 'package:claim_online/features/claim/claim_status/domain/entities/data_claim_status.dart';
import 'package:claim_online/features/claim/claim_status/domain/usecases/get_all_claim_status.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/error/failure.dart';

part 'claim_status_event.dart';
part 'claim_status_state.dart';

class ClaimStatusBloc extends Bloc<ClaimStatusEvent, ClaimStatusState> {
  final GetAllClaimStatus getAllClaimStatus;
  ClaimStatusBloc({
    required this.getAllClaimStatus,
  }) : super(ClaimStatusStateEmpty()) {
    on<ClaimStatusEventGetAllClaimStatus>((event, emit) async {
      try {
        emit(ClaimStatusStateLoading());
        Either<Failure, List<DataClaimStatus>> getAllClaimStatusResult =
            await getAllClaimStatus.call();
        getAllClaimStatusResult.fold((l) {
          if (l is ConnectionFailure) {
            emit(ClaimStatusStateError(message: l.message));
          } else if (l is ServerFailure) {
            emit(ClaimStatusStateError(message: l.message));
          } else if (l is GeneralFailure) {
            emit(ClaimStatusStateError(message: l.message));
          } else {
            emit(const ClaimStatusStateError(message: 'failed get all claim status'));
          }
        }, (r) => emit(ClaimStatusStateGetAllClaimStatus(claimStatus: r)));
      } catch (e) {
        emit(const ClaimStatusStateError(message: 'failed get all claim status'));
      }
    });
    on<ClaimStatusEventSortClaimStatus>((event, emit) async {
      try {
        emit(ClaimStatusStateLoading());
        emit(ClaimStatusStateSortClaimStatus(
          claimStatus: event.claimStatus,
          isAscending: event.isAscending,
          sortIndex: event.sortIndex,
        ));
      } catch (e) {
        emit(const ClaimStatusStateError(message: 'failed sort claim status'));
      }
    });
    on<ClaimStatusEventSearchClaimStatus>((event, emit) async {
      try {
        emit(ClaimStatusStateLoading());
        emit(
          ClaimStatusStateSearchClaimStatus(
            inputSearch: event.inputSearch,
            claimStatus: event.claimStatus,
          ),
        );
      } catch (e) {
        emit(const ClaimStatusStateError(
          message: "Failed search",
        ));
      }
    });
  }
}

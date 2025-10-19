import 'package:bloc/bloc.dart';
import 'package:claim_online/core/success/success.dart';
import 'package:claim_online/features/claim/claim/domain/entities/data_claim.dart';
import 'package:claim_online/features/claim/claim/domain/entities/data_claim_file_request.dart';
import 'package:claim_online/features/claim/claim/domain/entities/data_claim_request.dart';
import 'package:claim_online/features/claim/claim/domain/entities/data_claim_update_request.dart';
import 'package:claim_online/features/claim/claim/domain/usecases/add_claim.dart';
import 'package:claim_online/features/claim/claim/domain/usecases/add_claim_document.dart';
import 'package:claim_online/features/claim/claim/domain/usecases/delete_claim_document.dart';
import 'package:claim_online/features/claim/claim/domain/usecases/get_all_claim.dart';
import 'package:claim_online/features/claim/claim/domain/usecases/get_all_claim_category.dart';
import 'package:claim_online/features/claim/claim/domain/usecases/get_claim_by_claim_id.dart';
import 'package:claim_online/features/claim/claim/domain/usecases/update_claim.dart';
import 'package:claim_online/features/claim/claim/domain/usecases/update_claim_status.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../../../core/error/failure.dart';

part 'claim_event.dart';
part 'claim_state.dart';

class ClaimBloc extends Bloc<ClaimEvent, ClaimState> {
  final GetAllClaim getAllClaim;
  final GetClaimByuserid getClaimByuserid;
  final GetClaimByClaimId getClaimByClaimId;
  final AddClaim addClaim;
  final AddClaimDocument addClaimDocument;
  final DeleteClaimDocument deleteClaimDocument;
  final UpdateClaim updateClaim;
  final UpdateClaimStatus updateClaimStatus;
  ClaimBloc({
    required this.getAllClaim,
    required this.getClaimByuserid,
    required this.getClaimByClaimId,
    required this.addClaim,
    required this.addClaimDocument,
    required this.deleteClaimDocument,
    required this.updateClaim,
    required this.updateClaimStatus,
  }) : super(ClaimStateEmpty()) {
    on<ClaimEventGetAllClaim>((event, emit) async {
      try {
        emit(ClaimStateLoading());
        Either<Failure, List<DataClaim>> getAllClaimResult =
            await getAllClaim.call();
        getAllClaimResult.fold((l) {
          if (l is ConnectionFailure) {
            emit(ClaimStateError(message: l.message));
          } else if (l is ServerFailure) {
            emit(ClaimStateError(message: l.message));
          } else if (l is GeneralFailure) {
            emit(ClaimStateError(message: l.message));
          } else {
            emit(const ClaimStateError(message: 'failed get all claim'));
          }
        }, (r) => emit(ClaimStateGetAllClaim(claim: r)));
      } catch (e) {
        emit(const ClaimStateError(message: 'failed get all claim'));
      }
    });
    on<ClaimEventGetClaimByUserId>((event, emit) async {
      try {
        emit(ClaimStateLoading());
        Either<Failure, List<DataClaim>> getClaimByUserIdResult =
            await getClaimByuserid.call();
        getClaimByUserIdResult.fold((l) {
          if (l is ConnectionFailure) {
            emit(ClaimStateError(message: l.message));
          } else if (l is ServerFailure) {
            emit(ClaimStateError(message: l.message));
          } else if (l is GeneralFailure) {
            emit(ClaimStateError(message: l.message));
          } else {
            emit(const ClaimStateError(message: 'failed get claim by user id'));
          }
        }, (r) => emit(ClaimStateGetClaimByUserId(claim: r)));
      } catch (e) {
        emit(const ClaimStateError(message: 'failed get claim by user id'));
      }
    });
    on<ClaimEventGetClaimByClaimId>((event, emit) async {
      try {
        emit(ClaimStateLoading());
        Either<Failure, DataClaim> getClaimByClaimIdResult =
            await getClaimByClaimId.call(event.claimId);
        getClaimByClaimIdResult.fold((l) {
          if (l is ConnectionFailure) {
            emit(ClaimStateError(message: l.message));
          } else if (l is ServerFailure) {
            emit(ClaimStateError(message: l.message));
          } else if (l is GeneralFailure) {
            emit(ClaimStateError(message: l.message));
          } else {
            emit(
                const ClaimStateError(message: 'failed get claim by claim id'));
          }
        }, (r) => emit(ClaimStateGetClaimByClaimId(claim: r)));
      } catch (e) {
        emit(const ClaimStateError(message: 'failed get claim by claim id'));
      }
    });
    on<ClaimEventAddClaim>((event, emit) async {
      try {
        emit(ClaimStateLoading());
        Either<Failure, Success> addClaimResult =
            await addClaim.call(event.request);
        addClaimResult.fold((l) {
          if (l is ConnectionFailure) {
            emit(ClaimStateError(message: l.message));
          } else if (l is ServerFailure) {
            emit(ClaimStateError(message: l.message));
          } else if (l is GeneralFailure) {
            emit(ClaimStateError(message: l.message));
          } else {
            emit(const ClaimStateError(message: 'failed add claim'));
          }
        }, (r) {
          if (r is GeneralSuccess) {
            emit(ClaimStateAddClaim(message: r.message));
          }
        });
      } catch (e) {
        emit(const ClaimStateError(message: 'failed add claim'));
      }
    });
    on<ClaimEventUpdateClaim>((event, emit) async {
      try {
        emit(ClaimStateLoading());
        Either<Failure, Success> updateClaimResult =
            await updateClaim.call(event.request);
        updateClaimResult.fold((l) {
          if (l is ConnectionFailure) {
            emit(ClaimStateError(message: l.message));
          } else if (l is ServerFailure) {
            emit(ClaimStateError(message: l.message));
          } else if (l is GeneralFailure) {
            emit(ClaimStateError(message: l.message));
          } else {
            emit(const ClaimStateError(message: 'failed update claim'));
          }
        }, (r) {
          if (r is GeneralSuccess) {
            emit(ClaimStateUpdateClaim(message: r.message));
          }
        });
      } catch (e) {
        emit(const ClaimStateError(message: 'failed update claim'));
      }
    });
    on<ClaimEventUpdateClaimStatus>((event, emit) async {
      try {
        emit(ClaimStateLoading());
        Either<Failure, Success> updateClaimStatusResult =
            await updateClaimStatus.call(event.claimId, event.statusId);
        updateClaimStatusResult.fold((l) {
          if (l is ConnectionFailure) {
            emit(ClaimStateError(message: l.message));
          } else if (l is ServerFailure) {
            emit(ClaimStateError(message: l.message));
          } else if (l is GeneralFailure) {
            emit(ClaimStateError(message: l.message));
          } else {
            emit(const ClaimStateError(message: 'failed update claim status'));
          }
        }, (r) {
          if (r is GeneralSuccess) {
            emit(ClaimStateUpdateClaimStatus(message: r.message));
          }
        });
      } catch (e) {
        emit(const ClaimStateError(message: 'failed update claim status'));
      }
    });
    on<ClaimEventAddClaimDocument>((event, emit) async {
      try {
        emit(ClaimStateLoading());
        Either<Failure, Success> addClaimDocumentResult =
            await addClaimDocument.call(event.claimId, event.request);
        addClaimDocumentResult.fold((l) {
          if (l is ConnectionFailure) {
            emit(ClaimStateError(message: l.message));
          } else if (l is ServerFailure) {
            emit(ClaimStateError(message: l.message));
          } else if (l is GeneralFailure) {
            emit(ClaimStateError(message: l.message));
          } else {
            emit(const ClaimStateError(message: 'failed add claim document'));
          }
        }, (r) {
          if (r is GeneralSuccess) {
            emit(ClaimStateAddClaimDocument(message: r.message));
          }
        });
      } catch (e) {
        emit(const ClaimStateError(message: 'failed add claim document'));
      }
    });
    on<ClaimEventDeleteClaimDocument>((event, emit) async {
      try {
        emit(ClaimStateLoading());
        Either<Failure, Success> deleteClaimDocumentResult =
            await deleteClaimDocument.call(event.fileId);
        deleteClaimDocumentResult.fold((l) {
          if (l is ConnectionFailure) {
            emit(ClaimStateError(message: l.message));
          } else if (l is ServerFailure) {
            emit(ClaimStateError(message: l.message));
          } else if (l is GeneralFailure) {
            emit(ClaimStateError(message: l.message));
          } else {
            emit(
                const ClaimStateError(message: 'failed delete claim document'));
          }
        }, (r) {
          if (r is GeneralSuccess) {
            emit(ClaimStateDeleteClaimDocument(message: r.message));
          }
        });
      } catch (e) {
        emit(const ClaimStateError(message: 'failed delete claim document'));
      }
    });
    on<ClaimEventSortClaim>((event, emit) async {
      try {
        emit(ClaimStateLoading());
        emit(ClaimStateSortClaim(
          claim: event.claim,
          isAscending: event.isAscending,
          sortIndex: event.sortIndex,
        ));
      } catch (e) {
        emit(const ClaimStateError(message: 'failed sort claim '));
      }
    });
    on<ClaimEventSearchClaim>((event, emit) async {
      try {
        emit(ClaimStateLoading());
        emit(
          ClaimStateSearchClaim(
            inputSearch: event.inputSearch,
            claim: event.claim,
          ),
        );
      } catch (e) {
        emit(const ClaimStateError(
          message: "Failed search",
        ));
      }
    });
  }
}

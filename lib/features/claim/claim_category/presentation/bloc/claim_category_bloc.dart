import 'package:bloc/bloc.dart';
import 'package:claim_online/features/claim/claim_category/domain/entities/data_claim_category.dart';
import 'package:claim_online/features/claim/claim_category/domain/usecases/get_all_claim_category.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/error/failure.dart';

part 'claim_category_event.dart';
part 'claim_category_state.dart';

class ClaimCategoryBloc extends Bloc<ClaimCategoryEvent, ClaimCategoryState> {
  final GetAllClaimCategory getAllClaimCategory;
  ClaimCategoryBloc({
    required this.getAllClaimCategory,
  }) : super(ClaimCategoryStateEmpty()) {
    on<ClaimCategoryEventGetAllClaimCategory>((event, emit) async {
      try {
        emit(ClaimCategoryStateLoading());
        Either<Failure, List<DataClaimCategory>> getAllClaimCategoryResult =
            await getAllClaimCategory.call();
        getAllClaimCategoryResult.fold((l) {
          if (l is ConnectionFailure) {
            emit(ClaimCategoryStateError(message: l.message));
          } else if (l is ServerFailure) {
            emit(ClaimCategoryStateError(message: l.message));
          } else if (l is GeneralFailure) {
            emit(ClaimCategoryStateError(message: l.message));
          } else {
            emit(const ClaimCategoryStateError(message: 'failed get all claim Category'));
          }
        }, (r) => emit(ClaimCategoryStateGetAllClaimCategory(claimCategory: r)));
      } catch (e) {
        emit(const ClaimCategoryStateError(message: 'failed get all claim Category'));
      }
    });
    on<ClaimCategoryEventSortClaimCategory>((event, emit) async {
      try {
        emit(ClaimCategoryStateLoading());
        emit(ClaimCategoryStateSortClaimCategory(
          claimCategory: event.claimCategory,
          isAscending: event.isAscending,
          sortIndex: event.sortIndex,
        ));
      } catch (e) {
        emit(const ClaimCategoryStateError(message: 'failed sort claim Category'));
      }
    });
    on<ClaimCategoryEventSearchClaimCategory>((event, emit) async {
      try {
        emit(ClaimCategoryStateLoading());
        emit(
          ClaimCategoryStateSearchClaimCategory(
            inputSearch: event.inputSearch,
            claimCategory: event.claimCategory,
          ),
        );
      } catch (e) {
        emit(const ClaimCategoryStateError(
          message: "Failed search",
        ));
      }
    });
  }
}

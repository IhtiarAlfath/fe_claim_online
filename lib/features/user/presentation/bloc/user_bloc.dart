import 'package:bloc/bloc.dart';
import 'package:claim_online/core/success/success.dart';
import 'package:claim_online/features/authentication/domain/entities/data_register.dart';
import 'package:claim_online/features/user/domain/entities/data_user.dart';
import 'package:claim_online/features/user/domain/entities/data_user_role.dart';
import 'package:claim_online/features/user/domain/usecases/get_all_user.dart';
import 'package:claim_online/features/user/domain/usecases/get_all_user_role.dart';
import 'package:claim_online/features/user/domain/usecases/update_user.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failure.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetAllUserRole getAllUserRole;
  final GetAllUser getAllUser;
  final UpdateUser updateUser;
  UserBloc({
    required this.getAllUserRole,
    required this.getAllUser,
    required this.updateUser,
  }) : super(UserStateEmpty()) {
    on<UserEventGetAllUserRole>((event, emit) async {
      try {
        emit(UserStateLoading());
        Either<Failure, List<DataUserRole>> getAllUserRoleResult =
            await getAllUserRole.call();
        getAllUserRoleResult.fold((l) {
          if (l is ConnectionFailure) {
            emit(UserStateError(message: l.message));
          } else if (l is ServerFailure) {
            emit(UserStateError(message: l.message));
          } else if (l is GeneralFailure) {
            emit(UserStateError(message: l.message));
          } else {
            emit(const UserStateError(message: 'failed get all user role'));
          }
        }, (r) => emit(UserStateGetAllUserRole(userRole: r)));
      } catch (e) {
        emit(const UserStateError(message: 'failed get all user role'));
      }
    });
    on<UserEventGetAllUser>((event, emit) async {
      try {
        emit(UserStateLoading());
        Either<Failure, List<DataUser>> getAllUserResult =
            await getAllUser.call();
        getAllUserResult.fold((l) {
          if (l is ConnectionFailure) {
            emit(UserStateError(message: l.message));
          } else if (l is ServerFailure) {
            emit(UserStateError(message: l.message));
          } else if (l is GeneralFailure) {
            emit(UserStateError(message: l.message));
          } else {
            emit(const UserStateError(message: 'failed get all user '));
          }
        }, (r) => emit(UserStateGetAllUser(user: r)));
      } catch (e) {
        emit(const UserStateError(message: 'failed get all user '));
      }
    });
    on<UserEventUpdateUser>((event, emit) async {
      try {
        emit(UserStateLoading());
        Either<Failure, Success> updateUserResult =
            await updateUser.call(event.datauser);
        updateUserResult.fold(
          (l) {
            if (l is ConnectionFailure) {
              emit(UserStateError(message: l.message));
            } else if (l is ServerFailure) {
              emit(UserStateError(message: l.message));
            } else if (l is GeneralFailure) {
              emit(UserStateError(message: l.message));
            } else {
              emit(const UserStateError(message: 'failed update user '));
            }
          },
          (r) {
            if (r is GeneralSuccess) {
              return emit(UserStateUpdateUser(message: r.message));
            }
          },
        );
      } catch (e) {
        emit(const UserStateError(message: 'failed update user '));
      }
    });
    on<UserEventSortUser>((event, emit) async {
      try {
        emit(UserStateLoading());
        emit(UserStateSortUser(
          user: event.user,
          isAscending: event.isAscending,
          sortIndex: event.sortIndex,
        ));
      } catch (e) {
        emit(const UserStateError(message: 'failed sort user '));
      }
    });
    on<UserEventSearchUser>((event, emit) async {
      try {
        emit(UserStateLoading());
        emit(
          UserStateSearchUser(
            inputSearch: event.inputSearch,
            user: event.user,
          ),
        );
      } catch (e) {
        emit(const UserStateError(
          message: "Failed search",
        ));
      }
    });
  }
}

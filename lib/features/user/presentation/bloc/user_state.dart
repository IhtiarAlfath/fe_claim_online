part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState([List<dynamic> props = const <dynamic>[]]);
}

class UserStateEmpty extends UserState {
  @override
  List<Object?> get props => [];
}

class UserStateLoading extends UserState {
  @override
  List<Object?> get props => [];
}

class UserStateError extends UserState {
  final String message;

  const UserStateError({required this.message});
  @override
  List<Object?> get props => [message];
}

class UserStateGetAllUserRole extends UserState {
  final List<DataUserRole> userRole;

  const UserStateGetAllUserRole(
      {required this.userRole});
  @override
  List<Object?> get props => [userRole];
}

class UserStateGetAllUser extends UserState {
  final List<DataUser> user;

  const UserStateGetAllUser(
      {required this.user});
  @override
  List<Object?> get props => [user];
}

class UserStateUpdateUser extends UserState {
  final String message;

  const UserStateUpdateUser(
      {required this.message});
  @override
  List<Object?> get props => [message];
}

class UserStateAddUser extends UserState {
  final String message;

  const UserStateAddUser(
      {required this.message});
  @override
  List<Object?> get props => [message];
}

class UserStateSortUser extends UserState {
  final List<DataUser> user;
  final bool isAscending;
  final int sortIndex;

  const UserStateSortUser({
    required this.user,
    required this.isAscending,
    required this.sortIndex,
  });
  @override
  List<Object?> get props => [user, isAscending, sortIndex];
}

class UserStateSearchUser extends UserState {
  final String inputSearch;
  final List<DataUser> user;
  const UserStateSearchUser({
    required this.inputSearch,
    required this.user,
  });

  @override
  List<Object?> get props => [
        inputSearch,
        user,
      ];
}

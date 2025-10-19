part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent([List<dynamic> props = const <dynamic>[]]);
}

class UserEventGetAllUserRole extends UserEvent {
  const UserEventGetAllUserRole();
  @override
  List<Object?> get props => [];
}

class UserEventGetAllUser extends UserEvent {
  const UserEventGetAllUser();
  @override
  List<Object?> get props => [];
}

class UserEventUpdateUser extends UserEvent {
  final DataUser datauser;
  const UserEventUpdateUser({required this.datauser});
  @override
  List<Object?> get props => [datauser];
}

class UserEventAddUser extends UserEvent {
  final DataRegister dataRegister;
  const UserEventAddUser({required this.dataRegister});
  @override
  List<Object?> get props => [dataRegister];
}

class UserEventSortUser extends UserEvent {
  final List<DataUser> user;
  final bool isAscending;
  final int sortIndex;
  const UserEventSortUser({
    required this.user,
    required this.isAscending,
    required this.sortIndex,
  });
  @override
  List<Object?> get props => [
        user,
        isAscending,
        sortIndex,
      ];
}

class UserEventSearchUser extends UserEvent {
  final String inputSearch;
  final List<DataUser> user;

  const UserEventSearchUser({
    required this.inputSearch,
    required this.user,
  });

  @override
  List<Object?> get props => [
        inputSearch,
        user,
      ];
}

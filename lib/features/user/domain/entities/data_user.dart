import 'package:equatable/equatable.dart';

class DataUser extends Equatable {
  final String username;
  final String userId;
  final String email;
  final String roleId;

  const DataUser({
    required this.username,
    required this.userId,
    required this.email,
    required this.roleId,
  });


  @override
  List<Object?> get props => [
        username,
        userId,
        email,
        roleId,
      ];
}

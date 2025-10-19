import 'package:equatable/equatable.dart';

class DataRegister extends Equatable {
  final String username;
  final String email;
  final String password;
  final String roleId;

  const DataRegister({
    required this.email,
    required this.username,
    required this.password,
    required this.roleId,
  });

  @override
  List<Object?> get props => [
        email,
        username,
        password,
        roleId,
      ];
}

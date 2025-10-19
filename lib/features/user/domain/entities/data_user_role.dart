import 'package:equatable/equatable.dart';

class DataUserRole extends Equatable {
  final String userRoleId;
  final String userRoleName;

  const DataUserRole({
    required this.userRoleId,
    required this.userRoleName,
  });
  @override
  List<Object?> get props => [
        userRoleId,
        userRoleName,
      ];
}

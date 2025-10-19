import 'package:equatable/equatable.dart';

class DataUserToken extends Equatable {
  final String username;
  final String userId;
  final String email;
  final String roleId;
  final String token;

  const DataUserToken({
    required this.username,
    required this.userId,
    
    
    required this.email,
    required this.roleId,
    required this.token,
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'user_id': userId,
        'email': email,
        'role_id': roleId,
        'token': token,
      };

  factory DataUserToken.fromJson(Map<String, dynamic> json) => DataUserToken(
        username: json['username'] ?? '',
        userId: json['user_id'] ?? '',
        email: json['email'] ?? '',
        roleId: json['role_id'] ?? '',
        token: json['token'] ?? '',
      );

  @override
  List<Object?> get props => [
        username,
        userId,
        email,
        roleId,
        token,
      ];
}

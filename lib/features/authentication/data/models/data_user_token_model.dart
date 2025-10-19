import 'package:json_annotation/json_annotation.dart';
import 'package:claim_online/features/authentication/domain/entities/data_user_token.dart';

part 'data_user_token_model.g.dart';

@JsonSerializable()
class DataUserTokenModel extends DataUserToken {
  @JsonKey(name: 'role_id')
  final String roleId_;
  @JsonKey(name: 'user_id')
  final String userId_;

  const  DataUserTokenModel({
    required super.email,
    required super.token,
    required super.username,
    required this.roleId_,
    required this.userId_,
  }) : super(
          roleId: roleId_,
          userId: userId_,
        );

  factory DataUserTokenModel.fromJson(Map<String, dynamic> json) =>
      _$DataUserTokenModelFromJson(json);

  Map<String, dynamic> toJson() => _$DataUserTokenModelToJson(this);
}

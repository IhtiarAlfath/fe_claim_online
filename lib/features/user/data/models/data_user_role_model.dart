import 'package:claim_online/features/user/domain/entities/data_user_role.dart';
import 'package:json_annotation/json_annotation.dart';

part 'data_user_role_model.g.dart';

@JsonSerializable()
class DataUserRoleModel extends DataUserRole {
  @JsonKey(name: 'role_id')
  final String userRoleId_;
  @JsonKey(name: 'role_desc')
  final String userRoleName_;

  const DataUserRoleModel({
    required this.userRoleId_,
    required this.userRoleName_,
  }) : super(
          userRoleId: userRoleId_,
          userRoleName: userRoleName_,
        );

  factory DataUserRoleModel.fromJson(Map<String, dynamic> json) =>
      _$DataUserRoleModelFromJson(json);

  Map<String, dynamic> toJson() => _$DataUserRoleModelToJson(this);
}

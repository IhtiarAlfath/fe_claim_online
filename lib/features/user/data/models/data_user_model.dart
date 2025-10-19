import 'package:claim_online/features/user/domain/entities/data_user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'data_user_model.g.dart';

@JsonSerializable()
class DataUserModel extends DataUser {
  @JsonKey(name: 'user_id')
  final String userId_;
  @JsonKey(name: 'role_id')
  final String roleId_;


  const DataUserModel({
    required this.userId_,
    required super.email,
    required super.username,
    required this.roleId_,
  }) : super(
          userId: userId_,
          roleId: roleId_,
        );

  factory DataUserModel.fromJson(Map<String, dynamic> json) =>
      _$DataUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$DataUserModelToJson(this);
}

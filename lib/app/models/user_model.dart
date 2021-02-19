import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  String email;
  String tipoCadastro;
  String imgAvatar;

  UserModel(
    this.email,
    this.tipoCadastro,
    this.imgAvatar,
  );

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

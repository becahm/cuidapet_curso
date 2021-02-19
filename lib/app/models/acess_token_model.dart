import 'package:json_annotation/json_annotation.dart';

part 'acess_token_model.g.dart';

@JsonSerializable()
class AcessTokenModel {
  @JsonKey(name: 'access_token')
  String acessToken;

  AcessTokenModel(
    this.acessToken,
  );

  factory AcessTokenModel.fromJson(Map<String, dynamic> json) =>
      _$AcessTokenModelFromJson(json);
  Map<String, dynamic> toJson() => _$AcessTokenModelToJson(this);
}

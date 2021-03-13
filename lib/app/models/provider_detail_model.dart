import 'package:json_annotation/json_annotation.dart';

import 'package:cuidapet_curso/app/models/category_model.dart';

part 'provider_detail_model.g.dart';

@JsonSerializable()
class ProviderDetailModel {
  int id;
  String nome;
  String logo;
  String endereco;
  String telefone;
  double latitude;
  double longitude;
  CategoryModel category;

  ProviderDetailModel(
    this.id,
    this.nome,
    this.logo,
    this.endereco,
    this.telefone,
    this.latitude,
    this.longitude,
    this.category,
  );

  factory ProviderDetailModel.fromJson(Map<String, dynamic> json) =>
      _$ProviderDetailModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProviderDetailModelToJson(this);
}

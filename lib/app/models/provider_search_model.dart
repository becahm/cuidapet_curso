import 'package:json_annotation/json_annotation.dart';

import 'category_model.dart';

part 'provider_search_model.g.dart';

@JsonSerializable()
class ProviderSearchModel {
  int id;
  String nome;
  String logo;

  double distancia;
  CategoryModel categoria;

  ProviderSearchModel(
    this.id,
    this.nome,
    this.logo,
    this.distancia,
    this.categoria,
  );

  factory ProviderSearchModel.fromJson(Map<String, dynamic> json) =>
      _$ProviderSearchModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProviderSearchModelToJson(this);
}

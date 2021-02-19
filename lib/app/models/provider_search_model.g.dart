// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider_search_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProviderSearchModel _$ProviderSearchModelFromJson(Map<String, dynamic> json) {
  return ProviderSearchModel(
    json['id'] as int,
    json['nome'] as String,
    json['logo'] as String,
    (json['distancia'] as num)?.toDouble(),
    json['categoria'] == null
        ? null
        : CategoryModel.fromJson(json['categoria'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ProviderSearchModelToJson(
        ProviderSearchModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nome': instance.nome,
      'logo': instance.logo,
      'distancia': instance.distancia,
      'categoria': instance.categoria,
    };

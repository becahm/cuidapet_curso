// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProviderDetailModel _$ProviderDetailModelFromJson(Map<String, dynamic> json) {
  return ProviderDetailModel(
    json['id'] as int,
    json['nome'] as String,
    json['logo'] as String,
    json['endereco'] as String,
    json['telefone'] as String,
    (json['latitude'] as num)?.toDouble(),
    (json['longitude'] as num)?.toDouble(),
    json['category'] == null
        ? null
        : CategoryModel.fromJson(json['category'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ProviderDetailModelToJson(
        ProviderDetailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nome': instance.nome,
      'logo': instance.logo,
      'endereco': instance.endereco,
      'telefone': instance.telefone,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'category': instance.category,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceModel _$ServiceModelFromJson(Map<String, dynamic> json) {
  return ServiceModel(
    json['id'] as int,
    json['fornecedorId'] as int,
    json['nome'] as String,
    (json['valor'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$ServiceModelToJson(ServiceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fornecedorId': instance.fornecedorId,
      'nome': instance.nome,
      'valor': instance.valor,
    };

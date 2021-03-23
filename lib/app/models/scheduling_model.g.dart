// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scheduling_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SchedulingModel _$SchedulingModelFromJson(Map<String, dynamic> json) {
  return SchedulingModel(
    json['id'] as int,
    json['nome'] as String,
    json['nomePet'] as String,
    json['dataAgendamento'] == null
        ? null
        : DateTime.parse(json['dataAgendamento'] as String),
    json['fornecedor'] == null
        ? null
        : ProviderDetailModel.fromJson(
            json['fornecedor'] as Map<String, dynamic>),
    json['status'] as String,
    (json['servicos'] as List)
        ?.map((e) =>
            e == null ? null : ServiceModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$SchedulingModelToJson(SchedulingModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nome': instance.nome,
      'nomePet': instance.nomePet,
      'dataAgendamento': instance.dataAgendamento?.toIso8601String(),
      'fornecedor': instance.fornecedor,
      'status': instance.status,
      'servicos': instance.servicos,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatModel _$ChatModelFromJson(Map<String, dynamic> json) {
  return ChatModel(
    json['id'] as int,
    json['usuario'] as int,
    json['nome'] as String,
    json['nome_pet'] as String,
    json['fornecedor'] == null
        ? null
        : ProviderDetailModel.fromJson(
            json['fornecedor'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ChatModelToJson(ChatModel instance) => <String, dynamic>{
      'id': instance.id,
      'usuario': instance.usuario,
      'nome': instance.nome,
      'nome_pet': instance.nomePet,
      'fornecedor': instance.fornecedor,
    };

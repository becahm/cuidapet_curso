import 'package:json_annotation/json_annotation.dart';

import 'package:cuidapet_curso/app/models/provider_detail_model.dart';

part 'chat_model.g.dart';

@JsonSerializable()
class ChatModel {
  int id;
  int usuario;
  String nome;
  @JsonKey(name: 'nome_pet')
  String nomePet;
  ProviderDetailModel fornecedor;
  ChatModel(
    this.id,
    this.usuario,
    this.nome,
    this.nomePet,
    this.fornecedor,
  );

  factory ChatModel.fromJson(Map<String, dynamic> json) =>
      _$ChatModelFromJson(json);
  Map<String, dynamic> toJson() => _$ChatModelToJson(this);
}

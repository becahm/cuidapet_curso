import 'package:json_annotation/json_annotation.dart';

import 'package:cuidapet_curso/app/models/provider_detail_model.dart';
import 'package:cuidapet_curso/app/models/service_model.dart';

part 'scheduling_model.g.dart';

@JsonSerializable()
class SchedulingModel {
  int id;
  String nome;
  String nomePet;
  DateTime dataAgendamento;
  ProviderDetailModel fornecedor;
  String status;
  List<ServiceModel> servicos;

  SchedulingModel(
    this.id,
    this.nome,
    this.nomePet,
    this.dataAgendamento,
    this.fornecedor,
    this.status,
    this.servicos,
  );

  factory SchedulingModel.fromJson(Map<String, dynamic> json) =>
      _$SchedulingModelFromJson(json);
  Map<String, dynamic> toJson() => _$SchedulingModelToJson(this);
}

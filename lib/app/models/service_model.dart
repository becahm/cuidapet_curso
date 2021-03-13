import 'package:json_annotation/json_annotation.dart';

part 'service_model.g.dart';

@JsonSerializable()
class ServiceModel {
  int id;
  int fornecedorId;
  String nome;
  double valor;

  ServiceModel(
    this.id,
    this.fornecedorId,
    this.nome,
    this.valor,
  );

  factory ServiceModel.fromJson(Map<String, dynamic> json) =>
      _$ServiceModelFromJson(json);
  Map<String, dynamic> toJson() => _$ServiceModelToJson(this);
}

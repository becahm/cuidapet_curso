import 'dart:convert';

class AddressModel {
  int id;
  String endereco;
  double latitude;
  double longitude;
  String complemento;
  AddressModel({
    this.id,
    this.endereco,
    this.latitude,
    this.longitude,
    this.complemento,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'endereco': endereco,
      'latitude': latitude,
      'longitude': longitude,
      'complemento': complemento,
    };
  }

  AddressModel.fromMap(Map<String, dynamic> map) {
    if (map != null) {
      id = map['id'] as int;
      endereco = map['endereco'] as String;
      latitude = map['latitude'].runtimeType == String
          ? double.parse(map['latitude'])
          : map['latitude'] as double;
      longitude = map['longitude'].runtimeType == String
          ? double.parse(map['longitude'])
          : map['longitude'] as double;

      complemento = map['complemento'] as String;
    }
  }

  String toJson() => json.encode(toMap());

  factory AddressModel.fromJson(String source) =>
      AddressModel.fromMap(json.decode(source));
}

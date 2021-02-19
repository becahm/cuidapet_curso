// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return UserModel(
    json['email'] as String,
    json['tipoCadastro'] as String,
    json['imgAvatar'] as String,
  );
}

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'email': instance.email,
      'tipoCadastro': instance.tipoCadastro,
      'imgAvatar': instance.imgAvatar,
    };

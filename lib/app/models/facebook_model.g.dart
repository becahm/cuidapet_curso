// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'facebook_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FacebookModel _$FacebookModelFromJson(Map<String, dynamic> json) {
  return FacebookModel(
    json['email'] as String,
    FacebookModel._pictureFromJson(json['picture'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$FacebookModelToJson(FacebookModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'picture': instance.picture,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rest_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RestData _$RestDataFromJson(Map<String, dynamic> json) => RestData(
      json['name'] as String,
      RestVector3.fromJson(json['location'] as Map<String, dynamic>),
      RestVector3.fromJson(json['scale'] as Map<String, dynamic>),
      RestMaterial.fromJson(json['material'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RestDataToJson(RestData instance) => <String, dynamic>{
      'name': instance.name,
      'location': instance.location.toJson(),
      'scale': instance.scale.toJson(),
      'material': instance.material.toJson(),
    };

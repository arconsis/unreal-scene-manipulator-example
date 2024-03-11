// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rest_material.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RestMaterial _$RestMaterialFromJson(Map<String, dynamic> json) => RestMaterial(
      json['materialName'] as String,
      (json['tintIntensity'] as num).toDouble(),
      (json['redTint'] as num).toDouble(),
      (json['greenTint'] as num).toDouble(),
      (json['blueTint'] as num).toDouble(),
    );

Map<String, dynamic> _$RestMaterialToJson(RestMaterial instance) =>
    <String, dynamic>{
      'materialName': instance.materialName,
      'tintIntensity': instance.tintIntensity,
      'redTint': instance.redTint,
      'greenTint': instance.greenTint,
      'blueTint': instance.blueTint,
    };

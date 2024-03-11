// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rest_vector_three.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RestVector3 _$RestVector3FromJson(Map<String, dynamic> json) => RestVector3(
      (json['xCoordinate'] as num).toDouble(),
      (json['yCoordinate'] as num).toDouble(),
      (json['zCoordinate'] as num).toDouble(),
    );

Map<String, dynamic> _$RestVector3ToJson(RestVector3 instance) =>
    <String, dynamic>{
      'xCoordinate': instance.xCoordinate,
      'yCoordinate': instance.yCoordinate,
      'zCoordinate': instance.zCoordinate,
    };

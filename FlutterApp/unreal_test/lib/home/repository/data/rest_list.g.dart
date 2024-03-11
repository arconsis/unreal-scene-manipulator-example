// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rest_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RestList _$RestListFromJson(Map<String, dynamic> json) => RestList(
      (json['objects'] as List<dynamic>)
          .map((e) => RestData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RestListToJson(RestList instance) => <String, dynamic>{
      'objects': instance.objects.map((e) => e.toJson()).toList(),
    };

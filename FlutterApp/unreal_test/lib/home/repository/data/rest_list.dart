import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:unreal_test/home/repository/data/rest_data.dart';

part "rest_list.g.dart";

@JsonSerializable(
  explicitToJson: true,
)
class RestList extends Equatable {
  final List<RestData> objects;

  const RestList(this.objects);

  // From Json Constructor
  factory RestList.fromJson(Map<String, dynamic> json) => _$RestListFromJson(json);

  // To Json Methode
  Map<String, dynamic> toJson() => _$RestListToJson(this);

  // Equatable props
  @override
  List<Object> get props => [objects];
}
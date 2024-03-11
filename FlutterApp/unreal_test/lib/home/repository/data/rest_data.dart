import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:unreal_test/home/repository/data/rest_material.dart';
import 'package:unreal_test/home/repository/data/rest_vector_three.dart';

part "rest_data.g.dart";

@JsonSerializable(
  explicitToJson: true,
)
class RestData extends Equatable {
  final String name;
  final RestVector3 location;
  final RestVector3 scale;
  final RestMaterial material;

  // Constructor
  const RestData(this.name, this.location, this.scale, this.material);

  // From Json Constructor
  factory RestData.fromJson(Map<String, dynamic> json) => _$RestDataFromJson(json);

  // To Json Methode
  Map<String, dynamic> toJson() => _$RestDataToJson(this);

  // Equatable props
  @override
  List<Object> get props => [name, location, scale, material];
}
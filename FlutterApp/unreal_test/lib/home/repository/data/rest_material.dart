import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part "rest_material.g.dart";

@JsonSerializable()
class RestMaterial extends Equatable {
  final String materialName;
  final double tintIntensity;
  final double redTint;
  final double greenTint;
  final double blueTint;

  // Constructor
  const RestMaterial(this.materialName, this.tintIntensity, this.redTint, this.greenTint, this.blueTint);

  // From Json Constructor
  factory RestMaterial.fromJson(Map<String, dynamic> json) => _$RestMaterialFromJson(json);

  // To Json Methode
  Map<String, dynamic> toJson() => _$RestMaterialToJson(this);

  // Equatable props
  @override
  List<Object> get props => [materialName, tintIntensity, redTint, greenTint, blueTint];
}
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part "rest_vector_three.g.dart";

@JsonSerializable()
class RestVector3 extends Equatable {
  final double xCoordinate;
  final double yCoordinate;
  final double zCoordinate;

  // Constructor
  const RestVector3(this.xCoordinate, this.yCoordinate, this.zCoordinate);

  // From Json Constructor
  factory RestVector3.fromJson(Map<String, dynamic> json) => _$RestVector3FromJson(json);

  // To Json Methode
  Map<String, dynamic> toJson() => _$RestVector3ToJson(this);

  // Equatable props
  @override
  List<Object> get props => [xCoordinate, yCoordinate, zCoordinate];
}
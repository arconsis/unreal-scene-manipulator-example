import 'package:equatable/equatable.dart';
import 'package:unreal_test/home/repository/data/VectorThree.dart';
import 'package:unreal_test/home/repository/data/material.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class SendDataEvent extends HomeEvent {
  const SendDataEvent();
}

class UpdateCardValuesEvent extends HomeEvent {
  final int id;
  final String name;
  final VectorThree location;
  final VectorThree scale;
  final UEMaterial material;

  const UpdateCardValuesEvent({
    required this.id,
    required this.name,
    required this.location,
    required this.scale,
    required this.material,
  });

  @override
  List<Object> get props =>
      [...super.props, id, name, location, scale, material];
}

class AddCardEvent extends HomeEvent {
  const AddCardEvent();
}

class DismissCardEvent extends HomeEvent {
  final int id;

  const DismissCardEvent(this.id);

  @override
  List<Object> get props =>
      [...super.props, id];
}

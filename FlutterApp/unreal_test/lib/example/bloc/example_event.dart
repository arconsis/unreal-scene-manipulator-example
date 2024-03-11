import 'package:equatable/equatable.dart';

abstract class ExampleEvent extends Equatable {
  const ExampleEvent();

  @override
  List<Object> get props => [];
}

class InitializeData extends ExampleEvent {
  const InitializeData();
}

class UpdateIntegerEvent extends ExampleEvent {
  final int index;
  final int value;

  const UpdateIntegerEvent(this.index, this.value);

  @override
  List<Object> get props => [...super.props, index, value];
}
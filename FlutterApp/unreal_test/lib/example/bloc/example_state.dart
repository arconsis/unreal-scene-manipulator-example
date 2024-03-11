import 'package:equatable/equatable.dart';
import 'package:unreal_test/example/bloc/example_data.dart';

abstract class ExampleState extends Equatable {
  const ExampleState();

  @override
  List<Object> get props => [];
}

class UpdateState extends ExampleState {
  final List<ExampleData> updatedInteger;

  const UpdateState(this.updatedInteger);

  @override
  List<Object> get props => [...super.props, updatedInteger];
}
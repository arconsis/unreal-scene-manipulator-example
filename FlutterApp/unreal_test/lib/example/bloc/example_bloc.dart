import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unreal_test/example/bloc/example_data.dart';
import 'package:unreal_test/example/bloc/example_event.dart';
import 'package:unreal_test/example/bloc/example_state.dart';

class ExampleBloc extends Bloc<ExampleEvent, ExampleState> {
  final List<ExampleData> _list = [];

  ExampleBloc() : super(UpdateState([
    ExampleData(index: 0, value: 100, updateExampleData: (int index, int value) {}),
    ExampleData(index: 1, value: 200, updateExampleData: (int index, int value) {}),
    ExampleData(index: 2, value: 300, updateExampleData: (int index, int value) {}),
  ])) {
    on<InitializeData>(_init);
    on<UpdateIntegerEvent>(_updateInteger);
  }

  void _updateInteger(UpdateIntegerEvent event, Emitter emit) {
    _list[event.index] = ExampleData(
        index: event.index,
        value: event.value,
        updateExampleData: (int index, int value) =>
            add(UpdateIntegerEvent(index, value)));

    emit(UpdateState(List.of(_list)));

    // emit(state.copyWith(updatedList: _list));
  }

  void _init(event, Emitter emit) {
    emit(
      UpdateState([
        ExampleData(index: 0, value: 100, updateExampleData: (int index, int value) => add(UpdateIntegerEvent(index, value))),
        ExampleData(index: 1, value: 200, updateExampleData: (int index, int value) => add(UpdateIntegerEvent(index, value))),
        ExampleData(index: 2, value: 300, updateExampleData: (int index, int value) => add(UpdateIntegerEvent(index, value))),
      ])
    );
  }
}

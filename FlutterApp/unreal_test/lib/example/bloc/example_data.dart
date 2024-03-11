import 'package:equatable/equatable.dart';

class ExampleData extends Equatable {
  final int index;
  final int value;
  final void Function(int index, int value) updateExampleData;

  const ExampleData({required this.index, required this.value, required this.updateExampleData});

  @override
  List<Object> get props => [index, value, updateExampleData];
}
import 'package:equatable/equatable.dart';

import '../repository/data/Data.dart';

class HomeState extends Equatable {
  final List<Data> dataList;

  const HomeState(this.dataList);

  @override
  List<Object?> get props => [dataList];

  HomeState copyWith({List<Data>? dataList}) => HomeState(dataList ?? this.dataList);

}

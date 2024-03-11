import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:unreal_test/home/repository/data/Data.dart';
import 'package:unreal_test/home/repository/data/VectorThree.dart';
import 'package:unreal_test/home/repository/data/rest_data.dart';
import 'package:unreal_test/home/repository/data/rest_list.dart';
import 'package:unreal_test/home/repository/data/rest_vector_three.dart';
import 'package:unreal_test/home/repository/home_repository.dart';

import '../repository/data/material.dart';
import '../repository/data/rest_material.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final homeRepo = HomeRepository();
  int counter = 0;

  HomeBloc() : super(const HomeState([])) {
    on<SendDataEvent>((event, emit) => _sendData(event, emit));
    on<UpdateCardValuesEvent>(_updateData);
    on<AddCardEvent>(_addCard);
    on<DismissCardEvent>(_dismissCard);
  }

  void _sendData(SendDataEvent event, Emitter emit) {
    final dataList = List.of(state.dataList);

    List<RestData> list = [];

    for (var elem in dataList) {
      RestVector3 location = RestVector3(
          double.parse(elem.location.xCoordinate),
          double.parse(elem.location.yCoordinate),
          double.parse(elem.location.zCoordinate));
      RestVector3 scale = RestVector3(
          double.parse(elem.scale.xCoordinate),
          double.parse(elem.scale.yCoordinate),
          double.parse(elem.scale.zCoordinate));
      RestMaterial material = RestMaterial(
          elem.material.materialName,
          double.parse(elem.material.tintIntensity),
          double.parse(elem.material.redTint),
          double.parse(elem.material.greenTint),
          double.parse(elem.material.blueTint));
      RestData data = RestData(elem.id.toString(), location, scale, material);

      list.add(data);
    }

    RestList objects = RestList(list);

    final log = Logger();
    log.i(objects.toJson().toString());
    homeRepo.putOnStream(objects);
  }

  void _updateData(UpdateCardValuesEvent event, Emitter emit) {
    final dataList = List.of(state.dataList);
    int index = dataList.indexWhere((element) => element.id == event.id);

    dataList[index] = dataList[index].copyWith(
        id: event.id,
        name: event.name,
        location: event.location,
        scale: event.scale,
        material: event.material,
        updateData: (id, name, location, scale, material) =>
            add(UpdateCardValuesEvent(
              id: id,
              name: name,
              location: location,
              scale: scale,
              material: material,
            )));

    emit(state.copyWith(dataList: dataList));
  }

  void _dismissCard(DismissCardEvent event, Emitter emit) {
    final dataList = List.of(state.dataList);
    int index = dataList.indexWhere((element) => element.id == event.id);
    dataList.removeAt(index);

    emit(state.copyWith(dataList: dataList));
  }

  void _addCard(AddCardEvent event, Emitter emit) {
    final dataList = List.of(state.dataList);

    dataList.add(Data(
        counter,
        "Name",
        const VectorThree("0", "0", "0"),
        const VectorThree("0", "0", "0"),
        const UEMaterial("Wood", "0", "0", "0", "0"),
        (id, name, location, scale, material) => add(UpdateCardValuesEvent(
              id: id,
              name: name,
              location: location,
              scale: scale,
              material: material,
            ))));
    counter++;

    emit(state.copyWith(dataList: dataList));
  }
}

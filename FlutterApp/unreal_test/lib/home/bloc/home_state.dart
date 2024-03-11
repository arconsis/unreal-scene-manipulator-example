import 'package:equatable/equatable.dart';

import '../repository/data/Data.dart';

class HomeState extends Equatable {
  final List<Data> dataList;

  const HomeState(this.dataList);

  @override
  List<Object?> get props => [dataList];

  HomeState copyWith({List<Data>? dataList}) => HomeState(dataList ?? this.dataList);

}


/*
class UpdatedState extends Equatable {
  final String updatedName;
  final String updatedXLocation;
  final String updatedYLocation;
  final String updatedZLocation;
  final String updatedXScale;
  final String updatedYScale;
  final String updatedZScale;
  final String updatedMaterialName;
  final String updatedTintIntensity;
  final String updatedRedTint;
  final String updatedGreenTint;
  final String updatedBlueTint;

  const UpdatedState(
    this.updatedName,
    this.updatedXLocation,
    this.updatedYLocation,
    this.updatedZLocation,
    this.updatedXScale,
    this.updatedYScale,
    this.updatedZScale,
    this.updatedMaterialName,
    this.updatedTintIntensity,
    this.updatedRedTint,
    this.updatedGreenTint,
    this.updatedBlueTint,
  );

  UpdatedState copyWith(
          {String? updatedName,
          String? updatedXLocation,
          String? updatedYLocation,
          String? updatedZLocation,
          String? updatedXScale,
          String? updatedYScale,
          String? updatedZScale,
          String? updatedMaterialName,
          String? updatedTintIntensity,
          String? updatedRedTint,
          String? updatedGreenTint,
          String? updatedBlueTint}) =>
      UpdatedState(
          updatedName ?? this.updatedName,
          updatedXLocation ?? this.updatedXLocation,
          updatedYLocation ?? this.updatedYLocation,
          updatedZLocation ?? this.updatedZLocation,
          updatedXScale ?? this.updatedXScale,
          updatedYScale ?? this.updatedYScale,
          updatedZScale ?? this.updatedZScale,
          updatedMaterialName ?? this.updatedMaterialName,
          updatedTintIntensity ?? this.updatedTintIntensity,
          updatedRedTint ?? this.updatedRedTint,
          updatedGreenTint ?? this.updatedGreenTint,
          updatedBlueTint ?? this.updatedBlueTint);

  @override
  List<Object> get props => [
        updatedName,
        updatedXLocation,
        updatedYLocation,
        updatedZLocation,
        updatedXScale,
        updatedYScale,
        updatedZScale,
        updatedMaterialName,
        updatedRedTint,
        updatedGreenTint,
        updatedBlueTint
      ];
}

 */

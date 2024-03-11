import 'package:equatable/equatable.dart';

class UEMaterial extends Equatable{
  const UEMaterial(this.materialName, this.tintIntensity, this.redTint, this.greenTint, this.blueTint);

  final String materialName;
  final String tintIntensity;
  final String redTint;
  final String greenTint;
  final String blueTint;

  @override
  // TODO: implement props
  List<Object?> get props => [materialName, tintIntensity, redTint, greenTint, blueTint];

}
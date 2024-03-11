import 'package:equatable/equatable.dart';

class VectorThree extends Equatable {
  const VectorThree(this.xCoordinate, this.yCoordinate, this.zCoordinate);

  final String xCoordinate;
  final String yCoordinate;
  final String zCoordinate;

  @override
  // TODO: implement props
  List<Object?> get props => [xCoordinate, yCoordinate, zCoordinate];


}
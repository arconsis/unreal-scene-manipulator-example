import 'package:equatable/equatable.dart';
import 'package:unreal_test/home/repository/data/VectorThree.dart';

import 'material.dart';

class Data extends Equatable {
  const Data(this.id, this.name, this.location, this.scale, this.material,
      this.updateData);

  final int id;
  final String name;
  final VectorThree location;
  final VectorThree scale;
  final UEMaterial material;
  final void Function(int id, String name, VectorThree location,
      VectorThree scale, UEMaterial material) updateData;

  Data copyWith(
          {int? id,
          String? name,
          VectorThree? location,
          VectorThree? scale,
          UEMaterial? material,
          void Function(int id, String name, VectorThree location,
                  VectorThree scale, UEMaterial material)?
              updateData}) =>
      Data(
          id ?? this.id,
          name ?? this.name,
          location ?? this.location,
          scale ?? this.scale,
          material ?? this.material,
          updateData ?? this.updateData);

  @override
  List<Object?> get props => [id, name, location, scale, material, updateData];
}

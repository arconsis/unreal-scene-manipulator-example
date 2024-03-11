import 'package:flutter/material.dart';
import 'package:unreal_test/home/repository/data/Data.dart';
import 'package:unreal_test/home/repository/data/VectorThree.dart';

import '../../common/widgets/drop_down.dart';
import '../../common/widgets/number_field.dart';
import '../repository/data/material.dart';

class ObjectCard extends StatefulWidget {
  const ObjectCard({
    super.key,
    required this.id,
    required this.data,
    required this.dismissCard,
  });

  final int id;
  final Data data;
  final void Function(int) dismissCard;

  @override
  State<StatefulWidget> createState() => ObjectCardState();
}

class ObjectCardState extends State<ObjectCard> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lxController = TextEditingController();
  final TextEditingController lyController = TextEditingController();
  final TextEditingController lzController = TextEditingController();
  final TextEditingController sxController = TextEditingController();
  final TextEditingController syController = TextEditingController();
  final TextEditingController szController = TextEditingController();
  final TextEditingController materialController = TextEditingController();
  final TextEditingController redController = TextEditingController();
  final TextEditingController greenController = TextEditingController();
  final TextEditingController blueController = TextEditingController();
  final TextEditingController intensityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
      child: Card(
        child: ExpansionTile(
          title: Text(widget.data.name),
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const Text('Name'),
                TextField(
                  controller: nameController,
                  onChanged: (value) => _updateData(updatedName: value),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Name',
                  ),
                ),
                const SizedBox(height: 20),
                const Text('Location'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomNumberField(
                      fieldController: lxController,
                      onChanged: (value) =>
                          _updateData(updatedXLocation: value),
                      hintText: 'x-Axis',
                    ),
                    CustomNumberField(
                      fieldController: lyController,
                      onChanged: (value) =>
                          _updateData(updatedYLocation: value),
                      hintText: 'y-Axis',
                    ),
                    CustomNumberField(
                      fieldController: lzController,
                      onChanged: (value) =>
                          _updateData(updatedZLocation: value),
                      hintText: 'z-Axis',
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text('Scale'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomNumberField(
                      fieldController: sxController,
                      onChanged: (value) => _updateData(updatedXScale: value),
                      hintText: 'x-Axis',
                    ),
                    CustomNumberField(
                      fieldController: syController,
                      onChanged: (value) => _updateData(updatedYScale: value),
                      hintText: 'y-Axis',
                    ),
                    CustomNumberField(
                      fieldController: szController,
                      onChanged: (value) => _updateData(updatedZScale: value),
                      hintText: 'z-Axis',
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text('Material'),
                DropdownButtonExample(setDropDown: _getDropDownValue),
                const SizedBox(height: 10),
                const Text('Material Tint'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomNumberField(
                      fieldController: redController,
                      onChanged: (value) => _updateData(updatedRedTint: value),
                      hintText: 'red',
                    ),
                    CustomNumberField(
                      fieldController: greenController,
                      onChanged: (value) =>
                          _updateData(updatedGreenTint: value),
                      hintText: 'green',
                    ),
                    CustomNumberField(
                      fieldController: blueController,
                      onChanged: (value) => _updateData(updatedBlueTint: value),
                      hintText: 'blue',
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text('Tint Intensity'),
                TextField(
                    controller: intensityController,
                    onChanged: (value) =>
                        _updateData(updatedTintIntensity: value),
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Tint Intensity')),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    widget.dismissCard(widget.id);
                  },
                  child: const Text("Dismiss Card"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _initialize() {
    nameController.text = widget.data.name;
    lxController.text = widget.data.location.xCoordinate;
    lyController.text = widget.data.location.yCoordinate;
    lzController.text = widget.data.location.zCoordinate;
    sxController.text = widget.data.scale.xCoordinate;
    syController.text = widget.data.scale.yCoordinate;
    szController.text = widget.data.scale.zCoordinate;
    materialController.text = widget.data.material.materialName;
    redController.text = widget.data.material.redTint;
    greenController.text = widget.data.material.greenTint;
    blueController.text = widget.data.material.blueTint;
    intensityController.text = widget.data.material.tintIntensity;
  }

  void _getDropDownValue(String value) {
    materialController.text = value;
    _updateData(updatedMaterialName: value);
  }

  void _updateData(
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
      String? updatedBlueTint}) {
    widget.data.updateData(
      widget.data.id,
      updatedName ?? widget.data.name,
      VectorThree(
          updatedXLocation ?? widget.data.location.xCoordinate,
          updatedYLocation ?? widget.data.location.yCoordinate,
          updatedZLocation ?? widget.data.location.zCoordinate),
      VectorThree(
          updatedXScale ?? widget.data.scale.xCoordinate,
          updatedYScale ?? widget.data.scale.yCoordinate,
          updatedZScale ?? widget.data.scale.zCoordinate),
      UEMaterial(
        updatedMaterialName ?? widget.data.material.materialName,
        updatedTintIntensity ?? widget.data.material.tintIntensity,
        updatedRedTint ?? widget.data.material.redTint,
        updatedGreenTint ?? widget.data.material.greenTint,
        updatedBlueTint ?? widget.data.material.blueTint,
      ),
    );
  }
}

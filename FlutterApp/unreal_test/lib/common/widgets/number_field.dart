import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unreal_test/common/pattern.dart';

class CustomNumberField extends StatefulWidget {
  const CustomNumberField({super.key, required this.fieldController, required this.hintText, required this.onChanged});

  final TextEditingController fieldController;
  final String hintText;
  final void Function(String?) onChanged;

  @override
  State<CustomNumberField> createState() => _CustomNumberFieldState();
}

class _CustomNumberFieldState extends State<CustomNumberField> {

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        onChanged: widget.onChanged,
        controller: widget.fieldController,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(Patterns.onlyDecimals),
            TextInputFormatter.withFunction(
                  (oldValue, newValue) =>
                  newValue.copyWith(
                    text: newValue.text.replaceAll('.', ','),
                  ),
            ),
          ],
          decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: widget.hintText
          )
      ),
    );
  }

}
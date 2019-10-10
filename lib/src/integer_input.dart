import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:schema2app/schema2app.dart';

// TODO
// - Description
// - Min, max, step, use slider if min/max specified
// - Prefix/suffix units
// - Increase/decrease value with up/down arrow keys and +/- buttons
// - When click, if 0 delete existing value (maybe select all on click)

class IntegerInputComponent extends InputComponent {
  final String Function(String) validator;
  final _controller = TextEditingController();
  IntegerInputComponent(
    String name, {
    String label,
    String description,
    int value = 0,
    this.validator,
  }) : super(name, label, description) {
    this.value = value;
  }

  int get value => int.parse(_controller.text);
  set value(int value) => _controller.text = value.toString();

  @override
  State<StatefulWidget> createState() => _IntegerInputComponentState();
}

class _IntegerInputComponentState extends State<IntegerInputComponent> {
  @override
  Widget build(BuildContext context) => TextFormField(
        decoration: InputDecoration(labelText: widget.label),
        validator: widget.validator,
        autovalidate: widget.validator != null,
        controller: widget._controller,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          WhitelistingTextInputFormatter.digitsOnly,
        ],
      );
}

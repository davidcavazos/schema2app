import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:schema2app/schema2app.dart';

// TODO
// - Description
// - Min, max, step, use slider if min/max specified
// - Prefix/suffix units
// - Increase/decrease value with up/down arrow keys and +/- buttons
// - When click, if 0 delete existing value (maybe select all on click)
// - Support to start with . and add initial 0 if starts with .

class NumberInputComponent extends InputComponent {
  final String Function(String) validator;
  final _controller = TextEditingController();
  NumberInputComponent(
    String name, {
    String label,
    String description,
    num value = 0.0,
    this.validator,
  }) : super(name, label, description) {
    this.value = value;
  }

  double get value => double.parse(_controller.text);
  set value(num value) => _controller.text = value.toString();

  @override
  State<StatefulWidget> createState() => _NumberInputComponentState();
}

class _NumberInputComponentState extends State<NumberInputComponent> {
  @override
  Widget build(BuildContext context) => TextFormField(
        decoration: InputDecoration(labelText: widget.label),
        validator: widget.validator,
        autovalidate: widget.validator != null,
        controller: widget._controller,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          WhitelistingTextInputFormatter(RegExp(r'\d+\.?\d*')),
        ],
      );
}

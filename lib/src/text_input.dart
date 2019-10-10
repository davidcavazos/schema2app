import 'package:flutter/material.dart';
import 'package:schema2app/schema2app.dart';

// TODO
// - Description
// - Multiline
// - Font: sans, serif, monospace, custom
// - Check for non-empty string
// - Validator through regex

class TextInputComponent extends InputComponent {
  final String Function(String) validator;
  final _controller = TextEditingController();
  TextInputComponent(
    String name, {
    String label,
    String description,
    String value = '',
    this.validator,
  }) : super(name, label, description) {
    _controller.text = value;
  }

  String get value => _controller.text;
  set value(String value) => _controller.text = value;

  @override
  State<StatefulWidget> createState() => _TextInputComponentState();
}

class _TextInputComponentState extends State<TextInputComponent> {
  @override
  Widget build(BuildContext context) => TextFormField(
        decoration: InputDecoration(labelText: widget.label),
        validator: widget.validator,
        autovalidate: widget.validator != null,
        controller: widget._controller,
      );
}

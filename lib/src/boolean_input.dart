import 'package:flutter/material.dart';
import 'package:schema2app/schema2app.dart';

// TODO
// - Description

class BooleanInputComponent extends InputComponent {
  final ValueNotifier<bool> _notifier;
  BooleanInputComponent(
    String name, {
    String label,
    String description,
    bool value = false,
  })  : _notifier = ValueNotifier<bool>(value),
        super(name, label, description);

  bool get value => _notifier.value;
  set value(bool value) => _notifier.value = value;

  @override
  State<StatefulWidget> createState() => _BooleanInputComponentState();
}

class _BooleanInputComponentState extends State<BooleanInputComponent> {
  @override
  Widget build(BuildContext context) => SwitchListTile(
        title: Text(widget.label),
        subtitle: widget.description != null ? Text(widget.description) : null,
        value: widget.value,
        onChanged: (value) => setState(() {
          widget.value = value;
        }),
      );
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:schema2app/schema2app.dart';

class TextComponent extends Component {
  final TextEditingController _controller;
  TextComponent({String value, String label, bool editable})
      : _controller = TextEditingController(text: value ?? ''),
        super(value: value ?? '', label: label, editable: editable);

  TextComponent copyWith({String value, bool editable}) => TextComponent(
        value: value ?? this.value,
        label: label ?? this.label,
        editable: editable ?? this.editable,
      );

  Map<String, dynamic> toMap() => {
        'type': 'Text',
        'value': value,
        'label': label,
        'editable': editable,
      };

  static TextComponent fromMap(Map<String, dynamic> map) {
    if (map == null) map = {};
    return TextComponent(
      value: map['value'],
      label: map['label'],
      editable: map['editable'],
    );
  }

  static TextComponent fromJson(String source) => fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TextComponent &&
        other.value == value &&
        other.label == label &&
        other.editable == editable;
  }

  @override
  int get hashCode => value.hashCode ^ label.hashCode ^ editable.hashCode;

  @override
  String get data => _controller.text;
  String get value => data;

  @override
  State<StatefulWidget> createState() => _TextComponentState();
}

class _TextComponentState extends State<TextComponent> {
  @override
  Widget build(BuildContext context) {
    if (widget.editable)
      return TextField(
        decoration: InputDecoration(labelText: widget.label),
        controller: widget._controller,
      );
    return Text('Text: ${widget.value}');
  }
}

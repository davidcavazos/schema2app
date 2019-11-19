import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:schema2app/schema2app.dart';

class IntegerComponent extends Component {
  IntegerComponent({int value, String label, bool editable})
      : super(value: value ?? 0, label: label, editable: editable);

  IntegerComponent copyWith({int value, bool editable}) => IntegerComponent(
        value: value ?? this.value,
        label: label ?? this.label,
        editable: editable ?? this.editable,
      );

  Map<String, dynamic> toMap() => {
        'type': 'Integer',
        'value': value,
        'label': label,
        'editable': editable,
      };

  static IntegerComponent fromMap(Map<String, dynamic> map) {
    if (map == null) map = {};
    return IntegerComponent(
      value: map['value'],
      label: map['label'],
      editable: map['editable'],
    );
  }

  static IntegerComponent fromJson(String source) =>
      fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is IntegerComponent &&
        other.value == value &&
        other.label == label &&
        other.editable == editable;
  }

  @override
  int get hashCode => value.hashCode ^ label.hashCode ^ editable.hashCode;

  @override
  int get data => super.data;
  int get value => data;

  @override
  State<StatefulWidget> createState() => _IntegerComponentState();
}

class _IntegerComponentState extends State<IntegerComponent> {
  @override
  Widget build(BuildContext context) {
    return Text('Integer: ${widget.value}');
  }
}

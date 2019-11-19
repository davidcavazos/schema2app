import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:schema2app/schema2app.dart';

class NumberComponent extends Component {
  NumberComponent({double value, String label, bool editable})
      : super(value: value ?? 0.0, label: label, editable: editable);

  NumberComponent copyWith({double value, bool editable}) => NumberComponent(
        value: value ?? this.value,
        label: label ?? this.label,
        editable: editable ?? this.editable,
      );

  Map<String, dynamic> toMap() => {
        'type': 'Number',
        'value': value,
        'label': label,
        'editable': editable,
      };

  static NumberComponent fromMap(Map<String, dynamic> map) {
    if (map == null) map = {};
    return NumberComponent(
      value: map['value'],
      label: map['label'],
      editable: map['editable'],
    );
  }

  static NumberComponent fromJson(String source) =>
      fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is NumberComponent &&
        other.value == value &&
        other.label == label &&
        other.editable == editable;
  }

  @override
  int get hashCode => value.hashCode ^ label.hashCode ^ editable.hashCode;

  @override
  double get data => super.data;
  double get value => data;

  @override
  State<StatefulWidget> createState() => _NumberComponentState();
}

class _NumberComponentState extends State<NumberComponent> {
  @override
  Widget build(BuildContext context) {
    return Text('Number: ${widget.value}');
  }
}

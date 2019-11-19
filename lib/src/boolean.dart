import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:schema2app/schema2app.dart';

class BooleanComponent extends Component {
  BooleanComponent({bool value, String label, bool editable})
      : super(value: value ?? false, label: label, editable: editable);

  BooleanComponent copyWith({bool value, bool editable}) => BooleanComponent(
        value: value ?? this.value,
        label: label ?? this.label,
        editable: editable ?? this.editable,
      );

  Map<String, dynamic> toMap() => {
        'type': 'Boolean',
        'value': value,
        'label': label,
        'editable': editable,
      };

  static BooleanComponent fromMap(Map<String, dynamic> map) {
    if (map == null) map = {};
    return BooleanComponent(
      value: map['value'],
      label: map['label'],
      editable: map['editable'],
    );
  }

  static BooleanComponent fromJson(String source) =>
      fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is BooleanComponent &&
        other.value == value &&
        other.label == label &&
        other.editable == editable;
  }

  @override
  int get hashCode => value.hashCode ^ label.hashCode ^ editable.hashCode;

  @override
  bool get data => super.data;
  bool get value => data;

  @override
  State<StatefulWidget> createState() => _BooleanComponentState();
}

class _BooleanComponentState extends State<BooleanComponent> {
  @override
  Widget build(BuildContext context) {
    return Text('Boolean: ${widget.value}');
  }
}

import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:quiver/collection.dart';
import 'package:schema2app/schema2app.dart';

// TODO: Add (optional) type information
// TODO: Methods:
// - length
// - contains, containsAny, containsAll, add, remove
// - any, every
// - union, intersect, max, min

class SetComponent extends Component {
  SetComponent({Iterable values, String label, bool editable})
      : super(
          value: (values ?? []).map((x) => Component.from(x)).toSet(),
          label: label,
          editable: editable,
        );

  SetComponent copyWith({
    Iterable values,
    String label,
    bool editable,
  }) =>
      SetComponent(
        values: values ?? this.values,
        label: label ?? this.label,
        editable: editable ?? this.editable,
      );

  Map<String, dynamic> toMap() => {
        'type': 'Set',
        'values': values.map((x) => x.toMap()).toSet(),
        'label': label,
        'editable': editable,
      };

  static SetComponent fromMap(Map<String, dynamic> map) {
    if (map == null) map = {};
    return SetComponent(
      values:
          (map['values'] ?? []).map((x) => Component.fromMap(x)),
      label: map['label'],
      editable: map['editable'],
    );
  }

  String toJson() => json.encode(toMap());

  static SetComponent fromJson(String source) => fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SetComponent &&
        other.label == label &&
        other.editable == editable &&
        setsEqual(other.values, values);
  }

  @override
  int get hashCode => values.hashCode ^ label.hashCode ^ editable.hashCode;

  @override
  Set<Component> get data => super.data;
  Set get value => data.map((x) => x.data).toSet();
  Set get values => value;

  @override
  State<StatefulWidget> createState() => _SetComponentState();
}

class _SetComponentState extends State<SetComponent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.values.toList(),
    );
  }
}

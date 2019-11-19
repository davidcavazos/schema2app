import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:quiver/collection.dart';
import 'package:schema2app/schema2app.dart';

// TODO: Add (optional) type information
// TODO: Methods:
// - length
// - map, flatmap, filter, reduce
// - get, set, contains, add, remove, move
// - slice
// - sort, search
// - any, every
// - concatenate, enumerate, max, min, partition
// - zip

class ListComponent extends Component {
  ListComponent({Iterable values, String label, bool editable})
      : super(
          value: (values ?? []).map((x) => Component.from(x)).toList(),
          label: label,
          editable: editable,
        );

  ListComponent copyWith({
    Iterable values,
    String label,
    bool editable,
  }) =>
      ListComponent(
        values: values ?? this.values,
        label: label ?? this.label,
        editable: editable ?? this.editable,
      );

  Map<String, dynamic> toMap() => {
        'type': 'List',
        'values': values.map((x) => x.toMap()).toList(),
        'label': label,
        'editable': editable,
      };

  static ListComponent fromMap(Map<String, dynamic> map) {
    if (map == null) map = {};
    return ListComponent(
      values:
          (map['values'] ?? []).map((x) => Component.fromMap(x)),
      label: map['label'],
      editable: map['editable'],
    );
  }

  String toJson() => json.encode(toMap());

  static ListComponent fromJson(String source) => fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ListComponent &&
        other.label == label &&
        other.editable == editable &&
        listsEqual(other.values, values);
  }

  @override
  int get hashCode => values.hashCode ^ label.hashCode ^ editable.hashCode;

  @override
  List<Component> get data => super.data;
  List get value => data.map((x) => x.data).toList();
  List get values => value;

  @override
  State<StatefulWidget> createState() => _ListComponentState();
}

class _ListComponentState extends State<ListComponent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.values,
    );
  }
}

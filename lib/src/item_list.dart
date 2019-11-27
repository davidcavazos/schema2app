import 'dart:convert';

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

class ItemList extends Component {
  ItemList(
    Iterable values, {
    String label,
    Alignment align,
    bool editable,
    ValueNotifier notifier,
  }) : super(
          (values ?? []).map((x) => Component.from(x)).toList(),
          label: label,
          align: align,
          editable: editable,
          notifier: notifier,
        );

  @override
  List<Component> get data => super.data;
  @override
  List get value => data.map((x) => x.data).toList();
  List get values => value;

  ItemList copyWith({
    Iterable values,
    String label,
    Alignment align,
    bool editable,
    ValueNotifier notifier,
  }) =>
      ItemList(
        values ?? this.values,
        label: label ?? this.label,
        align: align ?? this.align,
        editable: editable ?? this.editable,
        notifier: notifier ?? this.notifier,
      );

  Map<String, dynamic> toMap() => {
        'type': 'List',
        'values': values.map((x) => x.toMap()).toList(),
        ...baseToMap(),
      };

  static ItemList fromMap(Map<String, dynamic> map) {
    if (map == null) map = {};
    return ItemList(
      (map['values'] ?? []).map((x) => Component.fromMap(x)),
      label: map['label'],
      align: alignFromMap(map['align']),
      editable: map['editable'],
    );
  }

  String toJson() => json.encode(toMap());

  static ItemList fromJson(String source) => fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ItemList &&
        baseEquals(other) &&
        listsEqual(other.values, values);
  }

  @override
  int get hashCode => values.hashCode ^ baseHashCode;

  @override
  Widget build(BuildContext context) => Section(values);
}

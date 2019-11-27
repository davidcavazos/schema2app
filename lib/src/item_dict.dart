import 'dart:convert';

import 'package:quiver/collection.dart';
import 'package:schema2app/schema2app.dart';

// TODO: Add (optional) type information
// TODO: Methods:
// - length
// - get, set, containsKey, add, remove, move
// - any, every
// - merge
// - entries, keys, values

class ItemDict extends Component {
  ItemDict(
    Map pairs, {
    String label,
    Alignment align,
    bool editable,
    ValueNotifier notifier,
  }) : super(
          Map.fromIterable(
            (pairs ?? {}).entries,
            key: (x) => x.key,
            value: (x) => Component.from(x.value),
          ),
          label: label,
          align: align,
          editable: editable,
          notifier: notifier,
        );

  @override
  Map<dynamic, Component> get data => super.data;
  @override
  Map get value => Map.fromIterable(
        data.entries,
        key: (x) => x.key,
        value: (x) => x.value.value,
      );
  Map get pairs => value;
  Iterable get keys => data.keys;
  Iterable get values => data.values.map((x) => x.value);

  ItemDict copyWith({
    Map pairs,
    String label,
    Alignment align,
    bool editable,
    ValueNotifier notifier,
  }) =>
      ItemDict(
        pairs ?? this.pairs,
        label: label ?? this.label,
        align: align ?? this.align,
        editable: editable ?? this.editable,
        notifier: notifier ?? this.notifier,
      );

  Map<String, dynamic> toMap() => {
        'type': 'Dictionary',
        'pairs': Map.fromIterable(
          pairs.entries,
          key: (x) => x.key,
          value: (x) => x.value.toMap(),
        ),
        ...baseToMap(),
      };

  static ItemDict fromMap(Map<String, dynamic> map) {
    if (map == null) map = {};
    return ItemDict(
      Map.fromIterable(
        (map['pairs'] ?? {}).entries,
        key: (x) => x.key,
        value: (x) => Component.fromMap(x.value),
      ),
      label: map['label'],
      align: alignFromMap(map['align']),
      editable: map['editable'],
    );
  }

  String toJson() => json.encode(toMap());

  static ItemDict fromJson(String source) => fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ItemDict &&
        baseEquals(other) &&
        mapsEqual(other.pairs, pairs);
  }

  @override
  int get hashCode => pairs.hashCode ^ baseHashCode;

  @override
  Widget build(BuildContext context) => Section(values);
}

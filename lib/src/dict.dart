import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:quiver/collection.dart';
import 'package:schema2app/schema2app.dart';

// TODO: Add (optional) type information
// TODO: Methods:
// - length
// - get, set, containsKey, add, remove, move
// - any, every
// - merge
// - entries, keys, values

class DictComponent extends Component {
  DictComponent({Map pairs, String label, bool editable})
      : super(
          value: Map.fromIterable(
            (pairs ?? {}).entries,
            key: (x) => x.key,
            value: (x) => Component.from(x.value),
          ),
          label: label,
          editable: editable,
        );

  DictComponent copyWith({
    Map pairs,
    String label,
    bool editable,
  }) =>
      DictComponent(
        pairs: pairs ?? this.pairs,
        label: label ?? this.label,
        editable: editable ?? this.editable,
      );

  Map<String, dynamic> toMap() => {
        'type': 'Dictionary',
        'pairs': Map.fromIterable(
          pairs.entries,
          key: (x) => x.key,
          value: (x) => x.value.toMap(),
        ),
        'label': label,
        'editable': editable,
      };

  static DictComponent fromMap(Map<String, dynamic> map) {
    if (map == null) map = {};
    return DictComponent(
      pairs: Map.fromIterable(
        (map['pairs'] ?? {}).entries,
        key: (x) => x.key,
        value: (x) => Component.fromMap(x.value),
      ),
      label: map['label'],
      editable: map['editable'],
    );
  }

  String toJson() => json.encode(toMap());

  static DictComponent fromJson(String source) => fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DictComponent &&
        other.label == label &&
        other.editable == editable &&
        mapsEqual(other.pairs, pairs);
  }

  @override
  int get hashCode => pairs.hashCode ^ label.hashCode ^ editable.hashCode;

  @override
  Map<dynamic, Component> get data => super.data;
  Map get value => Map.fromIterable(
        data.entries,
        key: (x) => x.key,
        value: (x) => x.value.value,
      );
  Map get pairs => value;
  Iterable get keys => data.keys;
  Iterable get values => data.values.map((x) => x.value);

  @override
  State<StatefulWidget> createState() => _DictionaryComponentState();
}

class _DictionaryComponentState extends State<ListComponent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.values,
    );
  }
}

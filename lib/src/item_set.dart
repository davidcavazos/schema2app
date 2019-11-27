import 'dart:convert';

import 'package:quiver/collection.dart';
import 'package:schema2app/schema2app.dart';

// TODO: Add (optional) type information
// TODO: Methods:
// - length
// - contains, containsAny, containsAll, add, remove
// - any, every
// - union, intersect, max, min

class ItemSet extends Component {
  ItemSet(
    Iterable values, {
    String label,
    Alignment align,
    bool editable,
    ValueNotifier notifier,
  }) : super(
          (values ?? []).map((x) => Component.from(x)).toSet(),
          label: label,
          align: align,
          editable: editable,
          notifier: notifier,
        );

  @override
  Set<Component> get data => super.data;
  @override
  Set get value => data.map((x) => x.data).toSet();
  Set get values => value;

  ItemSet copyWith({
    Iterable values,
    String label,
    Alignment align,
    bool editable,
    ValueNotifier notifier,
  }) =>
      ItemSet(
        values ?? this.values,
        label: label ?? this.label,
        align: align ?? this.align,
        editable: editable ?? this.editable,
        notifier: notifier ?? this.notifier,
      );

  Map<String, dynamic> toMap() => {
        'type': 'Set',
        'values': values.map((x) => x.toMap()).toSet(),
        ...baseToMap(),
      };

  static ItemSet fromMap(Map<String, dynamic> map) {
    if (map == null) map = {};
    return ItemSet(
      (map['values'] ?? []).map((x) => Component.fromMap(x)),
      label: map['label'],
      align: alignFromMap(map['align']),
      editable: map['editable'],
    );
  }

  String toJson() => json.encode(toMap());

  static ItemSet fromJson(String source) => fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ItemSet &&
        other.label == label &&
        other.align == align &&
        other.editable == editable &&
        setsEqual(other.values, values);
  }

  @override
  int get hashCode => values.hashCode ^ baseHashCode;

  @override
  Widget build(BuildContext context) => Section(values);
}

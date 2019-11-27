import 'dart:convert';

import 'package:flutter/widgets.dart' show Column, CrossAxisAlignment;
import 'package:quiver/collection.dart';

import 'package:schema2app/schema2app.dart';

// TODO: add keyboard and formatters
//       https://stackoverflow.com/questions/55631224/flutter-textfield-input-only-decimal-numbers

class Section extends Component {
  final Component floating;
  Section(
    Iterable values, {
    this.floating,
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

  Section copyWith({
    Iterable values,
    floating,
    String label,
    Alignment align,
    bool editable,
    ValueNotifier notifier,
  }) =>
      Section(
        values ?? this.values,
        floating: floating ?? this.floating,
        label: label ?? this.label,
        align: align ?? this.align,
        editable: editable ?? this.editable,
        notifier: notifier ?? this.notifier,
      );

  Map<String, dynamic> toMap() => {
        'type': 'Page',
        'values': values.map((x) => x.toMap()).toList(),
        'floating': floating,
        ...baseToMap(),
      };

  static Section fromMap(Map<String, dynamic> map) {
    if (map == null) map = {};
    return Section(
      map['values'],
      floating: map['floating'],
      label: map['label'],
      align: alignFromMap(map['align']),
      editable: map['editable'],
    );
  }

  static Section fromJson(String source) => fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Section &&
        other.floating == floating &&
        baseEquals(other) &&
        listsEqual(other.value, value);
  }

  @override
  int get hashCode => values.hashCode ^ floating.hashCode ^ baseHashCode;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: values,
      );
}

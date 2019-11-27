import 'dart:convert';

import 'package:schema2app/schema2app.dart';

// TODO: add methods:
// - toggle

class Boolean extends Component {
  Boolean(
    bool value, {
    Alignment align,
    String label,
    bool editable,
    ValueNotifier notifier,
  }) : super(
          value ?? false,
          align: align,
          label: label,
          editable: editable,
          notifier: notifier,
        );

  @override
  bool get data => super.data;
  @override
  bool get value => data;

  Boolean copyWith({
    bool value,
    String label,
    Alignment align,
    bool editable,
    ValueNotifier notifier,
  }) =>
      Boolean(
        value ?? this.value,
        label: label ?? this.label,
        align: align ?? this.align,
        editable: editable ?? this.editable,
        notifier: notifier ?? this.notifier,
      );

  Map<String, dynamic> toMap() => {
        'type': 'Boolean',
        'value': value,
        ...baseToMap(),
      };

  static Boolean fromMap(Map<String, dynamic> map) {
    if (map == null) map = {};
    return Boolean(
      map['value'],
      label: map['label'],
      align: alignFromMap(map['align']),
      editable: map['editable'],
    );
  }

  static Boolean fromJson(String source) => fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Boolean && other.value == value && baseEquals(other);
  }

  @override
  int get hashCode => value.hashCode ^ baseHashCode;

  @override
  Widget build(BuildContext context) => Text(
        "$value",
        label: label,
        align: align,
        editable: editable,
      );
}

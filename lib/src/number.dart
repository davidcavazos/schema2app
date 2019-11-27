import 'dart:convert';

import 'package:schema2app/schema2app.dart';

// TODO: add keyboard and formatters
//       https://stackoverflow.com/questions/55631224/flutter-textfield-input-only-decimal-numbers
// TODO: implement a proper inputFormatter

class Number extends Text {
  Number(
    double value, {
    List<TextInputFormatter> inputFormatters,
    TextInputType keyboard,
    TextStyle style,
    String label,
    Alignment align,
    bool editable,
    TextEditingController notifier,
  }) : super(
          '${value ?? 0.0}',
          inputFormatters: inputFormatters,
          keyboard: keyboard ??
              TextInputType.numberWithOptions(decimal: true, signed: true),
          style: style,
          label: label,
          align: align,
          editable: editable,
          notifier: notifier,
        );

  @override
  double get value => double.parse(data);

  Number copyWith({
    value,
    List<TextInputFormatter> inputFormatters,
    TextInputType keyboard,
    TextStyle style,
    String label,
    Alignment align,
    bool editable,
    TextEditingController notifier,
  }) =>
      Number(
        value ?? this.value,
        inputFormatters: inputFormatters ?? this.inputFormatters,
        keyboard: keyboard ?? this.keyboard,
        style: style ?? this.style,
        label: label ?? this.label,
        align: align ?? this.align,
        editable: editable ?? this.editable,
        notifier: notifier ?? this.notifier,
      );

  Map<String, dynamic> toMap() => {
        ...super.toMap(),
        'type': 'Number',
      };

  static Number fromMap(Map<String, dynamic> map) {
    if (map == null) map = {};
    return Number(
      map['value'],
      label: map['label'],
      align: alignFromMap(map['align']),
      editable: map['editable'],
    );
  }


  static Number fromJson(String source) => fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Number && other.value == value && baseEquals(other);
  }

  @override
  int get hashCode => value.hashCode ^ baseHashCode;
}

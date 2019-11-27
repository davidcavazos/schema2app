import 'dart:convert';

import 'package:schema2app/schema2app.dart';

// TODO: add increment/decrement buttons
//       https://stackoverflow.com/questions/57914542/is-there-a-number-input-field-in-flutter-with-increment-decrement-buttons-attach
//       https://stackoverflow.com/questions/50044618/how-to-increment-counter-for-a-specific-list-item-in-flutter

class Integer extends Text {
  Integer(
    int value, {
    List<TextInputFormatter> inputFormatters,
    TextInputType keyboard,
    TextStyle style,
    String label,
    Alignment align,
    bool editable,
    TextEditingController notifier,
  }) : super(
          '${value ?? 0}',
          inputFormatters:
              inputFormatters ?? [WhitelistingTextInputFormatter.digitsOnly],
          keyboard: keyboard ?? TextInputType.number,
          style: style,
          label: label,
          align: align,
          editable: editable,
          notifier: notifier,
        );

  @override
  int get value => int.parse(data);

  Integer copyWith({
    value,
    List<TextInputFormatter> inputFormatters,
    TextInputType keyboard,
    TextStyle style,
    String label,
    Alignment align,
    bool editable,
    TextEditingController notifier,
  }) =>
      Integer(
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
        'type': 'Integer',
      };

  static Integer fromMap(Map<String, dynamic> map) {
    if (map == null) map = {};
    return Integer(
      map['value'],
      label: map['label'],
      align: alignFromMap(map['align']),
      editable: map['editable'],
    );
  }

  static Integer fromJson(String source) => fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Integer && other.value == value && baseEquals(other);
  }

  @override
  int get hashCode => value.hashCode ^ baseHashCode;
}

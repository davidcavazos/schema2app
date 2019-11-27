import 'dart:convert';

import 'package:flutter/material.dart' show TextField;
import 'package:flutter/widgets.dart' as w;
import 'package:schema2app/schema2app.dart';

// TODO: toMap/fromMap on inputFormatter, keyboard, style
// TODO: add more styling customization options:
//   https://api.flutter.dev/flutter/painting/TextStyle-class.html

enum TextStyle {
  H1,
  H2,
  H3,
  H4,
  H5,
  H6,
  subtitle1,
  subtitle2,
  body1,
  body2,
  button,
  caption,
  overline,
}

class Text extends Component {
  final List<TextInputFormatter> inputFormatters;
  final TextInputType keyboard;
  final TextStyle style;
  Text(
    String value, {
    this.inputFormatters,
    this.keyboard,
    this.style,
    String label,
    Alignment align,
    bool editable,
    TextEditingController notifier,
  }) : super(
          value ?? '',
          label: label,
          align: align,
          editable: editable,
          notifier: notifier ?? TextEditingController(text: value ?? ''),
        );

  @override
  String get data => notifier.text;
  @override
  get value => data;
  @override
  set data(newValue) => notifier.text = '$newValue';
  @override
  set value(newValue) => data = newValue;
  @override
  TextEditingController get notifier => super.notifier;

  // Style shortcuts
  //   https://material.io/design/typography
  Text.h1(value, {Alignment align})
      : this(value, style: TextStyle.H1, align: align);
  Text.h2(value, {Alignment align})
      : this(value, style: TextStyle.H2, align: align);
  Text.h3(value, {Alignment align})
      : this(value, style: TextStyle.H3, align: align);
  Text.h4(value, {Alignment align})
      : this(value, style: TextStyle.H4, align: align);
  Text.h5(value, {Alignment align})
      : this(value, style: TextStyle.H5, align: align);
  Text.h6(value, {Alignment align})
      : this(value, style: TextStyle.H6, align: align);
  Text.subtitle1(value, {Alignment align})
      : this(value, style: TextStyle.subtitle1, align: align);
  Text.subtitle2(value, {Alignment align})
      : this(value, style: TextStyle.subtitle2, align: align);
  Text.body1(value, {Alignment align})
      : this(value, style: TextStyle.body1, align: align);
  Text.body2(value, {Alignment align})
      : this(value, style: TextStyle.body2, align: align);
  Text.button(value, {Alignment align})
      : this(value, style: TextStyle.button, align: align);
  Text.caption(value, {Alignment align})
      : this(value, style: TextStyle.caption, align: align);
  Text.overline(value, {Alignment align})
      : this(value, style: TextStyle.overline, align: align);
  Text.subtitle(value, {Alignment align}) : this.subtitle1(value, align: align);
  Text.body(value, {Alignment align}) : this.body1(value, align: align);

  copyWith({
    value,
    List<TextInputFormatter> inputFormatters,
    TextInputType keyboard,
    TextStyle style,
    String label,
    Alignment align,
    bool editable,
    TextEditingController notifier,
  }) =>
      Text(
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
        'type': 'Text',
        'value': value,
        ...baseToMap(),
      };

  static Text fromMap(Map<String, dynamic> map) {
    if (map == null) map = {};
    return Text(
      map['value'],
      label: map['label'],
      align: alignFromMap(map['align']),
      editable: map['editable'],
    );
  }

  static Text fromJson(String source) => fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Text && other.value == value && baseEquals(other);
  }

  @override
  int get hashCode => value.hashCode ^ baseHashCode;

  w.TextStyle _getStyle(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    switch (style) {
      case TextStyle.H1:
        return theme.display4;
      case TextStyle.H2:
        return theme.display3;
      case TextStyle.H3:
        return theme.display2;
      case TextStyle.H4:
        return theme.display1;
      case TextStyle.H5:
        return theme.headline;
      case TextStyle.H6:
        return theme.title;
      case TextStyle.subtitle1:
        return theme.subhead;
      case TextStyle.subtitle2:
        return theme.subtitle;
      case TextStyle.body1:
        return theme.body2;
      case TextStyle.body2:
        return theme.body1;
      case TextStyle.button:
        return theme.button;
      case TextStyle.caption:
        return theme.caption;
      case TextStyle.overline:
        return theme.overline;
    }
    return null; // unreachable
  }

  @override
  Widget build(BuildContext context) {
    if (!editable) return w.Text(value, style: _getStyle(context));
    return TextField(
      controller: notifier,
      decoration: InputDecoration(labelText: label),
      inputFormatters: inputFormatters,
      keyboardType: keyboard,
      style: _getStyle(context),
    );
  }
}

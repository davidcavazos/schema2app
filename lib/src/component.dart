import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:schema2app/src/builtin.dart';

abstract class Component extends StatefulWidget {
  final ValueNotifier _notifier;
  final String label;
  final bool editable;
  Component({@required value, @required String label, @required bool editable})
      : _notifier = value is ValueNotifier
            ? value
            : value is Component ? value._notifier : ValueNotifier(value),
        label = label ?? '',
        editable = editable ?? false;

  static final _lowerToUpperLetter = RegExp(r'([a-z])([A-Z])');
  static final _accronyms = RegExp(r'([A-Z]+)([A-Z][a-z]+)');
  static final _invalidCharacters = RegExp(r'[^a-zA-Z\d]+');
  static final _leadingOrTrailingUnderscores = RegExp(r'^_+|_+$');
  static String idFromText(String text) => text
      // camelCase => camel_Case
      .replaceAllMapped(
          _lowerToUpperLetter, (m) => '${m.group(1)}_${m.group(2)}')
      // ACCRONym => ACCRO_Nym
      .replaceAllMapped(_accronyms, (m) => '${m.group(1)}_${m.group(2)}')
      // UPPER_CASE => upper_case
      .toLowerCase()
      // invalid !@# characters => invalid_characters
      .replaceAll(_invalidCharacters, '_')
      // __leading_trailing__ ==> leading_traling
      .replaceAll(_leadingOrTrailingUnderscores, '');

  static Component from(value, {String label, bool editable}) {
    if (value is Component) return value;

    // Check for data types.
    if (value == null) return EmptyComponent();
    if (value == bool) return BooleanComponent(editable: editable);
    if (value == int) return IntegerComponent(editable: editable);
    if (value == num) return NumberComponent(label: label, editable: editable);
    if (value == String) return TextComponent(label: label, editable: editable);
    if (value == List) return ListComponent(label: label, editable: editable);

    // Check for values.
    if (value is bool)
      return BooleanComponent(value: value, label: label, editable: editable);
    if (value is int)
      return IntegerComponent(value: value, label: label, editable: editable);
    if (value is num)
      return NumberComponent(value: value, label: label, editable: editable);
    if (value is String)
      return TextComponent(value: value, label: label, editable: editable);
    if (value is Set)
      return SetComponent(values: value, label: label, editable: editable);
    if (value is Map)
      return DictComponent(pairs: value, label: label, editable: editable);
    if (value is Iterable)
      return ListComponent(values: value, label: label, editable: editable);
    if (value is Widget)
      return WidgetComponent(widget: value, label: label, editable: editable);

    throw UnsupportedError(
        'Component type not supported: ${value.runtimeType}');
  }

  get data => _notifier.value;
  get value;

  Map<String, dynamic> toMap();

  static Component fromMap(Map<String, dynamic> map) {
    if (!map.containsKey('type'))
      throw UnsupportedError('Component type not defined');
    switch (map['type']) {
      case 'Empty':
        return EmptyComponent();
      case 'Boolean':
        return BooleanComponent.fromMap(map);
      case 'Integer':
        return IntegerComponent.fromMap(map);
      case 'Number':
        return NumberComponent.fromMap(map);
      case 'Text':
        return TextComponent.fromMap(map);
      case 'List':
        return ListComponent.fromMap(map);
      case 'Set':
        return SetComponent.fromMap(map);
      case 'Dict':
        return DictComponent.fromMap(map);
      case 'Action':
        return ActionComponent.fromMap(map);
    }
    throw UnsupportedError("Component type not supported: ${map['type']}");
  }

  String toJson() => json.encode(toMap());
}

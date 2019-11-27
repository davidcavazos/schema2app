import 'dart:convert';

import 'package:schema2app/schema2app.dart';

// TODO: toMap/fromMap on notifier

abstract class Component extends StatefulWidget {
  final ValueNotifier notifier;
  final Alignment align;
  final String label;
  final bool editable;
  Component(
    value, {
    @required Alignment align,
    @required String label,
    @required bool editable,
    @required ValueNotifier notifier,
  })  : notifier = notifier ??
            (value is ValueNotifier
                ? value
                : value is Component ? value.notifier : ValueNotifier(value)),
        align = align ?? Alignment.topLeft,
        label = label ?? '',
        editable = editable ?? false;

  get data => notifier.value;
  get value => data;

  set data(newValue) => notifier.value = newValue;
  set value(newValue) => data = newValue;

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
    if (value == null) return Empty();
    if (value == bool) return Boolean(false, label: label, editable: editable);
    if (value == int) return Integer(0, label: label, editable: editable);
    if (value == num) return Number(0.0, label: label, editable: editable);
    if (value == String) return Text('', label: label, editable: editable);
    if (value == List) return ItemList([], label: label, editable: editable);
    if (value == Set) return ItemSet([], label: label, editable: editable);
    if (value == Map) return ItemDict({}, label: label, editable: editable);

    // Check for values.
    if (value is bool) return Boolean(value, label: label, editable: editable);
    if (value is int) return Integer(value, label: label, editable: editable);
    if (value is num) return Number(value, label: label, editable: editable);
    if (value is String) return Text(value, label: label, editable: editable);
    if (value is Set) return ItemSet(value, label: label, editable: editable);
    if (value is Map) return ItemDict(value, label: label, editable: editable);
    if (value is Iterable) // must be after all other iterables.
      return ItemList(value, label: label, editable: editable);
    if (value is Widget)
      return WidgetComponent(value, label: label, editable: editable);

    throw UnsupportedError(
        'Component type not supported: ${value.runtimeType}');
  }

  Map<String, dynamic> toMap();

  static Component fromMap(Map<String, dynamic> map) {
    if (!map.containsKey('type'))
      throw UnsupportedError('Component type not defined');
    switch (map['type']) {
      case 'Empty':
        return Empty();
      case 'Boolean':
        return Boolean.fromMap(map);
      case 'Integer':
        return Integer.fromMap(map);
      case 'Number':
        return Number.fromMap(map);
      case 'Text':
        return Text.fromMap(map);
      case 'List':
        return ItemList.fromMap(map);
      case 'Set':
        return ItemSet.fromMap(map);
      case 'Dict':
        return ItemDict.fromMap(map);
      case 'Button':
        return Button.fromMap(map);
    }
    throw UnsupportedError("Component type not supported: ${map['type']}");
  }

  String toJson() => json.encode(toMap());

  @protected
  Map<String, dynamic> baseToMap() => {
        'label': label,
        'align': alignToMap(align),
        'editable': editable,
      };

  @protected
  bool baseEquals(Object other) {
    if (identical(this, other)) return true;
    return other is Component &&
        other.label == label &&
        alignEquals(other.align, align) &&
        other.editable == editable;
  }

  @protected
  int get baseHashCode =>
      label.hashCode ^ alignHashCode(align) ^ editable.hashCode;

  Widget build(BuildContext context);

  @override
  State<StatefulWidget> createState() => ComponentState();
}

class ComponentState extends State<Component> {
  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: widget.notifier,
        builder: (context, value, child) => widget.build(context),
      );
}

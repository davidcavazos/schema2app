import 'dart:convert';

import 'package:flutter/widgets.dart' show SizedBox;
import 'package:schema2app/schema2app.dart';

class WidgetComponent extends Component {
  WidgetComponent(
    Widget widget, {
    String label,
    Alignment align,
    bool editable,
    ValueNotifier notifier,
  }) : super(
          widget ?? SizedBox.shrink(),
          label: label,
          align: align,
          editable: editable,
          notifier: notifier,
        );

  @override
  Widget get data => super.data;
  @override
  Widget get value => data;
  Widget get widget => data;

  WidgetComponent copyWith({
    Widget widget,
    String label,
    Alignment align,
    bool editable,
    ValueNotifier notifier,
  }) =>
      WidgetComponent(
        widget ?? this.widget,
        label: label ?? this.label,
        align: align ?? this.align,
        editable: editable ?? this.editable,
        notifier: notifier ?? this.notifier,
      );

  Map<String, dynamic> toMap() => {
        'type': 'Widget',
        'widget': widget.toString(),
        ...toMap(),
      };

  static WidgetComponent fromMap(Map<String, dynamic> map) {
    if (map == null) map = {};
    return WidgetComponent(
      map['widget'],
      label: map['label'],
      align: alignFromMap(map['align']),
      editable: map['editable'],
    );
  }

  static WidgetComponent fromJson(String source) =>
      fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is WidgetComponent &&
        other.widget == widget &&
        baseEquals(other);
  }

  @override
  int get hashCode => widget.hashCode ^ baseHashCode;

  @override
  Widget build(BuildContext context) => widget;
}

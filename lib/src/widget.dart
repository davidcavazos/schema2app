import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:schema2app/schema2app.dart';

class WidgetComponent extends Component {
  WidgetComponent({Widget widget, String label, bool editable})
      : super(
          value: widget ?? SizedBox.shrink(),
          label: label,
          editable: editable,
        );

  WidgetComponent copyWith({Widget widget, bool editable}) => WidgetComponent(
        widget: widget ?? this.widget,
        label: label ?? this.label,
        editable: editable ?? this.editable,
      );

  Map<String, dynamic> toMap() => {
        'type': 'Widget',
        'widget': widget.toString(),
        'label': label,
        'editable': editable,
      };

  static WidgetComponent fromMap(Map<String, dynamic> map) {
    if (map == null) map = {};
    return WidgetComponent(
      widget: map['widget'],
      label: map['label'],
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
        other.label == label &&
        other.editable == editable;
  }

  @override
  int get hashCode => widget.hashCode ^ label.hashCode ^ editable.hashCode;

  @override
  Widget get data => super.data;
  Widget get value => data;
  Widget get widget => data;

  @override
  State<StatefulWidget> createState() => _WidgetComponentState();
}

class _WidgetComponentState extends State<WidgetComponent> {
  @override
  Widget build(BuildContext context) => widget.widget;
}

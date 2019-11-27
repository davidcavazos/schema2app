import 'package:flutter/widgets.dart' show Alignment;

export 'package:flutter/material.dart' show InputDecoration, Theme;
export 'package:flutter/services.dart'
    show TextInputFormatter, WhitelistingTextInputFormatter;
export 'package:flutter/widgets.dart'
    show
        Alignment,
        BuildContext,
        Icon,
        State,
        StatefulWidget,
        TextEditingController,
        TextInputType,
        ValueListenableBuilder,
        ValueNotifier,
        Widget,
        protected,
        required;

Map<String, dynamic> alignToMap(Alignment align) =>
    {'x': align.x, 'y': align.y};

Alignment alignFromMap(Map<String, dynamic> map) {
  if (map == null) map = {};
  return Alignment(map['x'] ?? -1.0, map['y'] ?? -1.0);
}

bool alignEquals(Alignment a, Alignment b) => a.x == b.x && a.y == b.y;

int alignHashCode(Alignment align) => align.x.hashCode ^ align.y.hashCode;

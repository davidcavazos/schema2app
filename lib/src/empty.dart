import 'dart:convert';

import 'package:flutter/widgets.dart' show SizedBox;
import 'package:schema2app/schema2app.dart';

class Empty extends Component {
  Empty()
      : super(
          null,
          label: null,
          align: null,
          editable: null,
          notifier: null,
        );

  @override
  Null get data => super.data;
  @override
  Null get value => data;

  Map<String, dynamic> toMap() => {'type': 'Empty'};

  static Empty fromMap(Map<String, dynamic> map) => Empty();

  static Empty fromJson(String source) => fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Empty;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  Widget build(BuildContext context) => null;

  @override
  State<StatefulWidget> createState() => _EmptyState();
}

class _EmptyState extends State<Empty> {
  @override
  Widget build(BuildContext context) => SizedBox.shrink();
}

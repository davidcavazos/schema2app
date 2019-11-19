import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:schema2app/schema2app.dart';

class EmptyComponent extends Component {
  EmptyComponent() : super(value: null, label: '', editable: false);

  Map<String, dynamic> toMap() => {'type': 'Empty'};

  static EmptyComponent fromMap(Map<String, dynamic> map) => EmptyComponent();

  static EmptyComponent fromJson(String source) => fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is EmptyComponent;
  }

  @override
  int get hashCode => 0;

  @override
  Null get data => super.data;
  Null get value => data;

  @override
  State<StatefulWidget> createState() => _EmptyComponentState();
}

class _EmptyComponentState extends State<EmptyComponent> {
  @override
  Widget build(BuildContext context) => SizedBox.shrink();
}

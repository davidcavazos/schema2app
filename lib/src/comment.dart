import 'dart:convert';

import 'package:flutter/widgets.dart' show SizedBox;
import 'package:schema2app/schema2app.dart';

class Comment extends Component {
  Comment(String value)
      : super(
          value ?? '',
          align: null,
          label: null,
          editable: null,
          notifier: null,
        );

  @override
  String get data => super.data;
  @override
  String get value => data;

  Comment copyWith({String value}) => Comment(value ?? this.value);

  Map<String, dynamic> toMap() => {
        'type': 'Comment',
        'value': value,
      };

  static Comment fromMap(Map<String, dynamic> map) => Comment(map['value']);

  static Comment fromJson(String source) => fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Comment && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  Widget build(BuildContext context) => SizedBox.shrink();
}

import 'package:flutter/material.dart';
import 'package:schema2app/schema2app.dart';

class TextComponent extends Component {
  final String value;
  TextComponent(this.value);

  @override
  Widget build(BuildContext context) {
    return Text(value);
  }
}

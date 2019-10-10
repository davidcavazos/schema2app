import 'package:flutter/widgets.dart';

// TODO
// - Infer a better name, support snake_case, camelCase, PascalCase, hyphen-case

abstract class InputComponent extends StatefulWidget {
  final String name;
  final String label;
  final String description;
  InputComponent(this.name, String label, this.description)
      : label = label ?? name;

  get value;
}

import 'package:schema2app/schema2app.dart';

void main() => App(
    'Hello schema2app',
    ActionComponent(
      'Say hello',
      inputs: [
        TextInputComponent('Name'),
      ],
      action: (inputs) => "Hello ${inputs['hello']}!",
    )).run();

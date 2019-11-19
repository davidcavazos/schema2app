import 'package:schema2app/schema2app.dart';

void main() {
  var counter = NumberComponent();
  var app = App(
    'Hello schema2app',
    [
      "Here's the value of the counter so far:",
      counter,
      ActionComponent(
        'Add',
        function: () => print('Hello!'),
      ),
    ],
  );
  app.run();
}

// void main() => App(
//     'Hello schema2app!',
//     ActionComponent(
//       'Run',
//       inputs: {
//         'name': 'schema2app',
//       },
//       function: (inputs) => 'Hello ${inputs['name']}!',
//     )).run();

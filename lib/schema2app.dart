library schema2app;

import 'package:flutter/material.dart';

import 'src/builtin.dart';

export 'src/builtin.dart';

class App extends StatelessWidget {
  final String title;
  final Component root;
  App(this.title, [root]) : root = Component.from(root);

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: title,
        home: Scaffold(
          appBar: AppBar(title: Text(title)),
          body: root,
        ),
      );

  void run() => runApp(this);
}

library schema2app;

import 'package:flutter/material.dart';

import 'src/builtin.dart';

export 'src/builtin.dart';

class App extends StatelessWidget {
  final String name;
  final Widget root;
  App(this.name, root) : root = infer(root);

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: name,
        home: Scaffold(
          appBar: AppBar(title: Text(name)),
          body: root,
        ),
      );

  static Widget infer(x) {
    if (x is Widget) return x;
    switch (x.runtimeType) {
      case String:
        return TextComponent(x);
    }
    throw 'Could not infer type ${x.runtimeType}';
  }

  void run() => runApp(this);
}

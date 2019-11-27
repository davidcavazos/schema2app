library schema2app;

import 'package:flutter/material.dart' hide Text;

import 'src/component.dart';
import 'src/text.dart';

// exports
export 'src/flutter_exports.dart';

export 'src/component.dart';

export 'src/empty.dart';
export 'src/boolean.dart';
export 'src/integer.dart';
export 'src/number.dart';
export 'src/text.dart';

export 'src/item_list.dart';
export 'src/item_set.dart';
export 'src/item_dict.dart';

export 'src/button.dart';

export 'src/section.dart';
export 'src/comment.dart';

export 'src/widget.dart';

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

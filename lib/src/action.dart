import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:schema2app/schema2app.dart';

// TODO
// - Show outputs below, dialog box, snack bar, notification, new page (routing)
// - Cancelable opearations
// - Customize button

class ActionComponent extends InputComponent {
  final Function(Map<String, dynamic>) action;
  final Map<String, InputComponent> inputs;
  final Map<String, Component> outputs;
  ActionComponent(String name,
      {String label,
      String description,
      @required this.action,
      Iterable<InputComponent> inputs = const [],
      Iterable<Component> outputs = const []})
      : inputs = LinkedHashMap.fromIterable(inputs, key: (x) => x.name),
        outputs = LinkedHashMap.fromIterable(outputs, key: (x) => x.name),
        super(name, label, description);

  Function(Map<String, dynamic>) get value => action;

  @override
  State<StatefulWidget> createState() => _ActionComponentState();
}

class _ActionComponentState extends State<ActionComponent> {
  final _formKey = GlobalKey<FormState>();
  Future _result;

  @override
  void initState() {
    super.initState();
    // We need to initialize _result for FutureBuilder to render correctly.
    _result = null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ...widget.inputs.values,
          RaisedButton(
            child: Text(widget.label),
            onPressed: () => setState(() {
              // Wrap the action in an async function so it returns a Future to
              // be used by the FutureBuilder to show the results.
              var inputs = widget.inputs
                  .map((name, input) => MapEntry(name, input.value));
              var asyncAction = () async => widget.action(inputs);
              _result = asyncAction();
            }),
          ),
          FutureBuilder(
            future: _result,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return EmptyComponent();
                case ConnectionState.active:
                case ConnectionState.waiting:
                  return ProgressComponent();
                case ConnectionState.done:
                  if (snapshot.hasError)
                    return Text('Error: ${snapshot.error}');
                  return Text('${snapshot.data}');
              }
              return null; // unreachable
            },
          ),
        ],
      ),
    );
  }
}

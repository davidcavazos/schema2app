import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:schema2app/schema2app.dart';

class ActionComponent extends Component {
  final String name;
  final Map<String, Component> inputs;
  final Component outputs;
  ActionComponent(
    this.name, {
    Map<String, dynamic> inputs = const {},
    outputs,
    @required Function function,
    String label,
    bool editable,
  })  : inputs = inputs.map((name, input) =>
            MapEntry(name, Component.from(input, label: name, editable: true))),
        outputs = Component.from(outputs),
        super(
            value: _inferFunction(function), label: label, editable: editable);

  static Function _inferFunction(Function f) {
    if (f is Function(Map<String, dynamic>))
      return f;
    else if (f is Function()) return (inputs) => f();
    throw UnsupportedError('Unsupported function type ${f.runtimeType}, '
        'must be Function() or Function(Map<String, dynamic> inputs)');
  }

  ActionComponent copyWith({
    String name,
    Map<String, dynamic> inputs,
    outputs,
    Function function,
    String label,
    bool editable,
  }) =>
      ActionComponent(
        name ?? this.name,
        inputs: inputs ?? this.inputs,
        outputs: outputs ?? this.outputs,
        function: function ?? this.function,
        label: label ?? this.label,
        editable: editable ?? this.editable,
      );

  Map<String, dynamic> toMap() => {
        'type': 'Action',
        'name': name,
        'inputs': inputs.map((name, input) => MapEntry(name, input.toMap())),
        'outputs': outputs.toMap(),
        'function': value.toString(),
        'label': label,
        'editable': editable,
      };

  static ActionComponent fromMap(Map<String, dynamic> map) {
    if (map == null) map = {};
    return ActionComponent(
      map['name'],
      inputs: map['inputs'],
      outputs: map['outputs'],
      function: map['function'],
      label: map['label'],
      editable: map['editable'],
    );
  }

  static ActionComponent fromJson(String source) =>
      fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ActionComponent &&
        other.name == name &&
        other.inputs == inputs &&
        other.outputs == outputs &&
        other.function == function &&
        other.label == label &&
        other.editable == editable;
  }

  @override
  int get hashCode =>
      name.hashCode ^
      inputs.hashCode ^
      outputs.hashCode ^
      function.hashCode ^
      label.hashCode ^
      editable.hashCode;

  @override
  Function get data => super.data;
  Function get value => data;
  Function get function => value;

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
            child: Text(widget.name),
            onPressed: () => setState(() {
              // Wrap the action in an async function so it returns a Future to
              // be used by the FutureBuilder to show the results.
              var inputs = widget.inputs
                  .map((name, input) => MapEntry(name, input.value));
              var asyncFunction = () async => widget.function(inputs);
              _result = asyncFunction();
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
                  return CircularProgressIndicator();
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

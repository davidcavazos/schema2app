import 'dart:convert';

import 'package:flutter/material.dart'
    show
        Center,
        CircularProgressIndicator,
        ConnectionState,
        Form,
        FormState,
        FutureBuilder,
        GlobalKey,
        RaisedButton,
        ValueListenableBuilder;
import 'package:schema2app/schema2app.dart';

// TODO: add an option to customize/hide the loading animation
// TODO: disable the button while it's running
// TODO: have a way to cancel a job

class Button extends Component {
  final Map<String, Component> inputs;
  final Component output;
  final Icon icon;
  Button(
    Function function, {
    Map<String, dynamic> inputs = const {},
    output,
    this.icon,
    String label,
    Alignment align,
    bool editable,
    ValueNotifier notifier,
  })  : inputs = inputs.map((name, input) =>
            MapEntry(name, Component.from(input, label: name, editable: true))),
        output = Component.from(output),
        super(
          _inferFunction(function),
          label: label == null && icon == null ? 'Run' : label,
          align: align,
          editable: editable,
          notifier: notifier,
        );

  static Function _inferFunction(Function f) {
    if (f is Function(Map<String, dynamic>))
      return f;
    else if (f is Function()) return (inputs) => f();
    throw UnsupportedError('Unsupported function type ${f.runtimeType}, '
        'must be Function() or Function(Map<String, dynamic> inputs)');
  }

  Button copyWith({
    Function function,
    Map<String, dynamic> inputs,
    output,
    Icon icon,
    String label,
    Alignment align,
    bool editable,
    ValueNotifier notifier,
  }) =>
      Button(
        function ?? this.function,
        inputs: inputs ?? this.inputs,
        output: output ?? this.output,
        icon: icon ?? this.icon,
        label: label ?? this.label,
        align: align ?? this.align,
        editable: editable ?? this.editable,
        notifier: notifier ?? this.notifier,
      );

  Map<String, dynamic> toMap() => {
        'type': 'Action',
        'function': value.toString(),
        'inputs': inputs.map((name, input) => MapEntry(name, input.toMap())),
        'output': output.toMap(),
        'icon': icon,
        ...baseToMap(),
      };

  static Button fromMap(Map<String, dynamic> map) {
    if (map == null) map = {};
    return Button(
      map['function'],
      inputs: map['inputs'],
      output: map['output'],
      icon: map['icon'],
      label: map['label'],
      align: alignFromMap(map['align']),
      editable: map['editable'],
    );
  }

  static Button fromJson(String source) => fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Button &&
        other.function == function &&
        other.inputs == inputs &&
        other.output == output &&
        other.icon == icon &&
        baseEquals(other);
  }

  @override
  int get hashCode =>
      function.hashCode ^
      inputs.hashCode ^
      output.hashCode ^
      icon.hashCode ^
      baseHashCode;

  @override
  Function get data => super.data;
  Function get value => data;
  Function get function => value;

  @override
  Widget build(BuildContext context) => null;

  @override
  State<StatefulWidget> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  final _formKey = GlobalKey<FormState>();
  Future _result;

  @override
  void initState() {
    super.initState();
    // We need to initialize _result for FutureBuilder to render correctly.
    _result = null;
  }

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: widget.notifier,
        builder: (context, value, child) => Form(
          key: _formKey,
          child: Section([
            ...widget.inputs.values,
            RaisedButton(
              child: Text(widget.label),
              onPressed: () => setState(() {
                // Wrap the action in an async function so it returns a Future
                // to be used by the FutureBuilder to show the results.
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
                    return Empty();
                  case ConnectionState.active:
                  case ConnectionState.waiting:
                    return Center(child: CircularProgressIndicator());
                  case ConnectionState.done:
                    if (snapshot.hasError)
                      return Text('Error: ${snapshot.error}');
                    return Component.from(snapshot.data);
                }
                return null; // unreachable
              },
            ),
          ]),
        ),
      );
}

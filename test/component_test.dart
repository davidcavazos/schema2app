import 'package:flutter/widgets.dart' as w;
import 'package:flutter_test/flutter_test.dart';

import 'package:schema2app/schema2app.dart';

// TODO: add tests for Component.from(bool|int|num|String|List)
// TODO: test Component(value: ValueNotifier)
// TODO: test Component(value: Component)
// TODO: test Component(value: Any)
// TODO: Component(label)
// TODO: Component(editable)

class NotSupportedType {}

void main() {
  // static Component.idFromText
  test("static Component.idFromText: camelCase", () {
    expect(Component.idFromText('camelCase'), 'camel_case');
  });
  test("static Component.idFromText: PascalCase", () {
    expect(Component.idFromText('PascalCase'), 'pascal_case');
  });
  test("static Component.idFromText: ACRONym", () {
    expect(Component.idFromText('ACRONym'), 'acro_nym');
  });
  test("static Component.idFromText: UPPER_CASE", () {
    expect(Component.idFromText('UPPER_CASE'), 'upper_case');
  });
  test("static Component.idFromText: invalid !@# characters", () {
    expect(
        Component.idFromText('invalid !@# characters'), 'invalid_characters');
  });
  test("static Component.idFromText: ___leading_trailing___", () {
    expect(Component.idFromText('___leading_trailing___'), 'leading_trailing');
  });

  // Component.from
  test("Component.from: error: type not supported", () {
    expect(() => Component.from(NotSupportedType()), throwsUnsupportedError);
  });

  test("Component.from: EmptyComponent as EmptyComponent", () {
    expect(Component.from(EmptyComponent()), EmptyComponent());
  });
  test("Component.from: NumberComponent as NumberComponent", () {
    expect(Component.from(NumberComponent()), NumberComponent());
  });

  test("Component.from: null as Empty", () {
    expect(Component.from(null), EmptyComponent());
  });
  test("Component.from: bool as Boolean", () {
    expect(Component.from(bool), BooleanComponent());
  });
  test("Component.from: int as Integer", () {
    expect(Component.from(int), IntegerComponent());
  });
  test("Component.from: num as Number", () {
    expect(Component.from(num), NumberComponent());
  });
  test("Component.from: String as Text", () {
    expect(Component.from(String), TextComponent());
  });
  test("Component.from: List as List", () {
    expect(Component.from(List), ListComponent());
  });

  test("Component.from: false as Boolean", () {
    expect(Component.from(false), BooleanComponent(value: false));
  });
  test("Component.from: true as Boolean", () {
    expect(Component.from(true), BooleanComponent(value: true));
  });
  test("Component.from: 42 as Integer", () {
    expect(Component.from(42), IntegerComponent(value: 42));
  });
  test("Component.from: 3.14 as Number", () {
    expect(Component.from(3.14), NumberComponent(value: 3.14));
  });
  test("Component.from: 'text' as Text", () {
    expect(Component.from('text'), TextComponent(value: 'text'));
  });

  test("Component.from: [] as List", () {
    expect(Component.from([]), ListComponent());
  });
  test("Component.from: ['a', 'b', 'c'] as List", () {
    expect(
        Component.from(['a', 'b', 'c']),
        ListComponent(values: [
          TextComponent(value: 'a'),
          TextComponent(value: 'b'),
          TextComponent(value: 'c'),
        ]));
  });

  test("Component.from: Set() as Set", () {
    expect(Component.from(Set()), SetComponent());
  });
  test("Component.from: {'a', 'b', 'c'} as Set", () {
    expect(
        Component.from({'a', 'b', 'c'}),
        SetComponent(values: {
          TextComponent(value: 'a'),
          TextComponent(value: 'b'),
          TextComponent(value: 'c'),
        }));
  });

  test("Component.from: {} as Dict", () {
    expect(Component.from({}), DictComponent());
  });
  test("Component.from: {'integer': 42, 'text': 'hello'} as Dict", () {
    expect(
      Component.from({'integer': 42, 'text': 'hello'}),
      DictComponent(
        pairs: {
          'integer': IntegerComponent(value: 42),
          'text': TextComponent(value: 'hello'),
        },
      ),
    );
  });

  test("Component.from: Widget", () {
    expect((Component.from(w.Text('text')) as WidgetComponent).value.toString(),
        WidgetComponent(widget: w.Text('text')).value.toString());
  });

  // Component.fromMap
  test("Component.fromMap: type not defined", () {
    expect(() => Component.fromMap({'key': 'value'}), throwsUnsupportedError);
  });
  test("Component.fromMap: type not supported", () {
    expect(() => Component.fromMap({'type': 'NotSupportedType'}),
        throwsUnsupportedError);
  });

  test("Component.fromMap: Empty", () {
    expect(Component.fromMap({'type': 'Number', 'value': 3.14}),
        NumberComponent(value: 3.14));
  });
  test("Component.fromMap: Boolean", () {
    expect(Component.fromMap({'type': 'Boolean', 'value': true}),
        BooleanComponent(value: true));
  });
  test("Component.fromMap: Integer", () {
    expect(Component.fromMap({'type': 'Integer', 'value': 42}),
        IntegerComponent(value: 42));
  });
  test("Component.fromMap: Number", () {
    expect(Component.fromMap({'type': 'Number', 'value': 3.14}),
        NumberComponent(value: 3.14));
  });
  test("Component.fromMap: Text", () {
    expect(Component.fromMap({'type': 'Text', 'value': 'text'}),
        TextComponent(value: 'text'));
  });

  test("Component.fromMap: List empty", () {
    expect(Component.fromMap({'type': 'List'}), ListComponent());
  });
  test("Component.fromMap: List", () {
    expect(
        Component.fromMap({
          'type': 'List',
          'values': [
            {'type': 'Text', 'value': 'a'},
            {'type': 'Text', 'value': 'b'},
            {'type': 'Text', 'value': 'c'},
          ],
        }),
        ListComponent(values: [
          TextComponent(value: 'a'),
          TextComponent(value: 'b'),
          TextComponent(value: 'c'),
        ]));
  });

  test("Component.fromMap: Set empty", () {
    expect(Component.fromMap({'type': 'Set'}), SetComponent());
  });
  test("Component.fromMap: Set", () {
    expect(
        Component.fromMap({
          'type': 'Set',
          'values': {
            {'type': 'Text', 'value': 'a'},
            {'type': 'Text', 'value': 'b'},
            {'type': 'Text', 'value': 'c'},
          },
        }),
        SetComponent(values: {
          TextComponent(value: 'a'),
          TextComponent(value: 'b'),
          TextComponent(value: 'c'),
        }));
  });

  test("Component.fromMap: Dict empty", () {
    expect(Component.fromMap({'type': 'Dict'}), DictComponent());
  });
  test("Component.fromMap: Dict", () {
    expect(
        Component.fromMap({
          'type': 'Dict',
          'pairs': {
            'integer': {'type': 'Integer', 'value': 42},
            'text': {'type': 'Text', 'value': 'hello'},
          },
        }),
        DictComponent(pairs: {
          'integer': IntegerComponent(value: 42),
          'text': TextComponent(value: 'hello'),
        }));
  });

  test("Component.fromMap: Action", () {
    greet(name) => 'Hello $name!';
    expect(
        Component.fromMap({
          'type': 'Action',
          'name': 'Greet',
          'inputs': {'name': String},
          'outputs': String,
          'function': greet,
        }).toJson(),
        ActionComponent(
          'Greet',
          inputs: {'name': TextComponent(label: 'name', editable: true)},
          outputs: TextComponent(),
          function: greet,
        ).toJson());
  });
}

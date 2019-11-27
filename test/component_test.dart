import 'package:flutter/widgets.dart' as flutter;
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
    expect(Component.from(Empty()), Empty());
  });
  test("Component.from: NumberComponent as NumberComponent", () {
    expect(Component.from(Number(3.14)), Number(3.14));
  });

  test("Component.from: null as Empty", () {
    expect(Component.from(null), Empty());
  });
  test("Component.from: bool as Boolean", () {
    expect(Component.from(bool), Boolean(false));
  });
  test("Component.from: int as Integer", () {
    expect(Component.from(int), Integer(0));
  });
  test("Component.from: num as Number", () {
    expect(Component.from(num), Number(0.0));
  });
  test("Component.from: String as Text", () {
    expect(Component.from(String), Text(''));
  });
  test("Component.from: List as List", () {
    expect(Component.from(List), ItemList([]));
  });

  test("Component.from: false as Boolean", () {
    expect(Component.from(false), Boolean(false));
  });
  test("Component.from: true as Boolean", () {
    expect(Component.from(true), Boolean(true));
  });
  test("Component.from: 42 as Integer", () {
    expect(Component.from(42), Integer(42));
  });
  test("Component.from: 3.14 as Number", () {
    expect(Component.from(3.14), Number(3.14));
  });
  test("Component.from: 'text' as Text", () {
    expect(Component.from('text'), Text('text'));
  });

  test("Component.from: [] as List", () {
    expect(Component.from([]), ItemList([]));
  });
  test("Component.from: ['a', 'b', 'c'] as List", () {
    expect(Component.from(['a', 'b', 'c']),
        ItemList([Text('a'), Text('b'), Text('c')]));
  });

  test("Component.from: Set() as Set", () {
    expect(Component.from(Set()), ItemSet([]));
  });
  test("Component.from: {'a', 'b', 'c'} as Set", () {
    expect(Component.from({'a', 'b', 'c'}),
        ItemSet({Text('a'), Text('b'), Text('c')}));
  });

  test("Component.from: {} as Dict", () {
    expect(Component.from({}), ItemDict({}));
  });
  test("Component.from: {'integer': 42, 'text': 'hello'} as Dict", () {
    expect(
      Component.from({'integer': 42, 'text': 'hello'}),
      ItemDict({'integer': Integer(42), 'text': Text('hello')}),
    );
  });

  test("Component.from: Widget", () {
    expect(
        (Component.from(flutter.Text('text')) as WidgetComponent)
            .value
            .toString(),
        WidgetComponent(flutter.Text('text')).value.toString());
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
    expect(Component.fromMap({'type': 'Number', 'value': 3.14}), Number(3.14));
  });
  test("Component.fromMap: Boolean", () {
    expect(
        Component.fromMap({'type': 'Boolean', 'value': true}), Boolean(true));
  });
  test("Component.fromMap: Integer", () {
    expect(Component.fromMap({'type': 'Integer', 'value': 42}), Integer(42));
  });
  test("Component.fromMap: Number", () {
    expect(Component.fromMap({'type': 'Number', 'value': 3.14}), Number(3.14));
  });
  test("Component.fromMap: Text", () {
    expect(Component.fromMap({'type': 'Text', 'value': 'text'}), Text('text'));
  });

  test("Component.fromMap: List empty", () {
    expect(Component.fromMap({'type': 'List'}), ItemList([]));
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
        ItemList([Text('a'), Text('b'), Text('c')]));
  });

  test("Component.fromMap: Set empty", () {
    expect(Component.fromMap({'type': 'Set'}), ItemSet([]));
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
        ItemSet({Text('a'), Text('b'), Text('c')}));
  });

  test("Component.fromMap: Dict empty", () {
    expect(Component.fromMap({'type': 'Dict'}), ItemDict({}));
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
        ItemDict({'integer': Integer(42), 'text': Text('hello')}));
  });

  test("Component.fromMap: Button", () {
    greet(name) => 'Hello $name!';
    expect(
        Component.fromMap({
          'type': 'Button',
          'function': greet,
          'inputs': {'name': String},
        }).toJson(),
        Button(
          greet,
          inputs: {'name': Text('', label: 'name', editable: true)},
          label: 'Run',
        ).toJson());
  });
}

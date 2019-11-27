import 'package:schema2app/schema2app.dart';

void main() {
  var counter = Component.from(0);

  App(
    'Hello schema2app',
    Section(
      [
        Text.h3('Hello schema2app'),
        Comment('This is a comment, and is ignored'),
        Section(
          [
            'You have pushed the button this many times:',
            Text.h4(counter),
          ],
          align: Alignment.center,
        ),
      ],
      floating: Button(
        () {
          counter.value++;
        },
        // icon: Icon.add,
        label: 'Add',
        align: Alignment.bottomRight,
      ),
    ),
  ).run();
}

/* ===--- app.mdc ---=== *\
---
counter: 0
n: 1
---

# Hello schema2app

{# This is a comment, and is ignored }

{: align=center align-vertical=center }
'''
  You have pushed the button this many times:

  ## ${counter}
'''

{@ floating }
{{ Button increment-counter(n) icon=add }}
*/

/* ===--- main.dart ---=== *\
void main() => run('app.md', {
  'increment-counter': (fields) {
    fields['counter']++;
  },
});
*/

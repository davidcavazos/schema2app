import 'package:flutter/widgets.dart';
import 'package:schema2app/schema2app.dart';

class ParagraphComponent extends ListComponent {
  ParagraphComponent({Iterable values, String label, bool editable})
      : super(values: values, label: label, editable: editable);

  Map<String, dynamic> toMap() => {
        'type': 'Paragraph',
        'values': values.map((x) => x.toMap()).toList(),
        'label': label,
        'editable': editable,
      };

  @override
  State<StatefulWidget> createState() => _ParagraphComponentState();
}

class _ParagraphComponentState extends State<ParagraphComponent> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: widget.values,
    );
  }
}

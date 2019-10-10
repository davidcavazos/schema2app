import 'package:flutter/material.dart';
import 'package:schema2app/schema2app.dart';

// TODO
// - Support progress bar if progress or ETA is known

class ProgressComponent extends Component {
  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator();
  }
}

import 'package:flutter/material.dart';

import '../shared_widgets.dart' as shared;
import '../themes.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: backgroundBoxDecor,
      child: Center(child: shared.icon),
    );
  }
}

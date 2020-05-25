import 'package:flutter/material.dart';
import 'package:flutter_placeholder_textlines/placeholder_lines.dart';

class LoadingProject extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        PlaceholderLines(count: 3, align: TextAlign.center, lineHeight: 8, animate: true,),
        SizedBox(height: 30,)
      ],
    );
  }
}

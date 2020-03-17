import 'package:flutter/material.dart';

class ToggleButton extends StatelessWidget {
  final title;

  const ToggleButton({this.title});

  @override
  Widget build(BuildContext context) {
    return Container(padding: EdgeInsets.all(10), child: Text(title));
  }
}

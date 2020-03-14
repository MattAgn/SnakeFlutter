import 'package:flutter/material.dart';

class ControlButton extends StatelessWidget {
  final Widget child;
  final Function onPress;

  ControlButton({@required this.child, @required this.onPress});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: Center(child: child),
      onPressed: this.onPress,
      padding: EdgeInsets.all(40),
      elevation: 3,
      fillColor: Colors.green,
      shape: CircleBorder(),
    );
  }
}

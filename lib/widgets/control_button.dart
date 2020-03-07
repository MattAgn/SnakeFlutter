import 'package:flutter/material.dart';

class ControlButton extends StatelessWidget {
  final String text;
  final Function onPress;

  ControlButton({@required this.text, @required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RawMaterialButton(
        child: Text(this.text, style: TextStyle(fontSize: 30)),
        onPressed: this.onPress,
        padding: EdgeInsets.all(40),
        elevation: 3,
        fillColor: Colors.green,
        shape: CircleBorder(),
      ),
    );
  }
}

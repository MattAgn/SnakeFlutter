import 'package:flutter/material.dart';

class LevelButton extends StatelessWidget {
  final int index;
  final double buttonSize;
  final Function onPressed;

  LevelButton({this.index, this.buttonSize, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final buttonColor = onPressed != null ? Colors.white : Colors.grey;
    return RawMaterialButton(
      onPressed: onPressed,
      child: Container(
        width: buttonSize,
        height: buttonSize,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            border: Border.all(color: buttonColor, width: 2.5),
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Text(
          '$index',
          style: TextStyle(color: buttonColor, fontSize: 30),
        ),
      ),
    );
  }
}

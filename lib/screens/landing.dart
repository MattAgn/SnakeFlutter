import 'package:flutter/material.dart';

class Landing extends StatelessWidget {
  onPlay(context) {
    return () {
      Navigator.pushNamed(context, "/game_board");
    };
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              "Snake",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.green),
            ),
            RaisedButton(
              child: Text(
                "Play",
                style: TextStyle(fontSize: 20),
              ),
              onPressed: onPlay(context),
              padding: EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class Landing extends StatelessWidget {
  onPlay(context) {
    return () {
      Navigator.pushNamed(context, "/game");
    };
  }

  onPressLogin(context) {
    return () {
      Navigator.pushNamed(context, "/login");
    };
  }

  onPressLevels(context) {
    return () {
      Navigator.pushNamed(context, "/levels");
    };
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.black,
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
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
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
                ),
                SizedBox(height: 20),
                RaisedButton(
                  child: Text(
                    "Levels",
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: onPressLevels(context),
                  padding: EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                ),
                SizedBox(height: 20),
                RaisedButton(
                  child: Text(
                    "Login",
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: onPressLogin(context),
                  padding: EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

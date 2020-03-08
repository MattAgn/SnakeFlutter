import 'package:flutter/material.dart';
import 'package:snake_game/widgets/control_button.dart';

class GameBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text("Game"),
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              color: Colors.black,
              height: MediaQuery.of(context).size.height * 0.55,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    ControlButton(
                      text: "<",
                      onPress: () {},
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          ControlButton(onPress: () {}, text: "^"),
                          ControlButton(text: "v", onPress: () {}),
                        ],
                      ),
                    ),
                    ControlButton(
                      text: ">",
                      onPress: () {},
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

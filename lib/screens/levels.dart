import 'package:flutter/material.dart';
import 'package:snake_game/screens/game.dart';
import 'package:snake_game/widgets/button_level.dart';

class Levels extends StatelessWidget {
  Function onPressed(context, index) => () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Game(
                levelNumber: index,
              ),
            ));
      };

  @override
  Widget build(BuildContext context) {
    final levelButtonSize = MediaQuery.of(context).size.width / 7;

    return Scaffold(
      appBar: AppBar(
        title: Text("Levels"),
      ),
      backgroundColor: Colors.black,
      body: Container(
          padding: EdgeInsets.all(20),
          child: GridView.count(
            crossAxisCount: 4,
            children: List.generate(40, (index) {
              return LevelButton(
                buttonSize: levelButtonSize,
                index: index,
                onPressed: index < 3 ? onPressed(context, index) : null,
              );
            }),
          )),
    );
  }
}

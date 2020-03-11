import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snake_game/ecs/systems/main.dart';
import 'package:snake_game/widgets/control_button.dart';
import 'package:snake_game/widgets/game_board.dart';
import 'package:snake_game/widgets/lifecycle_button.dart';

class Game extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text("Game"),
      ),
      body: SafeArea(
        child: ChangeNotifierProvider<GameSystem>(
          create: (context) => GameSystem(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              GameBoard(),
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
              LifecycleButtons()
            ],
          ),
        ),
      ),
    );
  }
}

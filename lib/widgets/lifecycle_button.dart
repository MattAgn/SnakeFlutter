import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snake_game/ecs/systems/main.dart';

class LifecycleButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final gameSystem = Provider.of<GameSystem>(context, listen: true);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        gameSystem.gameStatus == GameStatus.play
            ? RaisedButton.icon(
                label: Text("Pause"),
                icon: Icon(Icons.pause_circle_filled),
                onPressed: gameSystem.pause,
              )
            : RaisedButton.icon(
                label: Text("Play"),
                icon: Icon(Icons.play_circle_filled),
                onPressed: gameSystem.play,
              ),
        RaisedButton.icon(
          label: Text("Stop"),
          icon: Icon(Icons.stop),
          onPressed: gameSystem.stop,
        )
      ],
    );
  }
}

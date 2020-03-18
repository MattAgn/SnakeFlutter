import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snake_game/ecs/systems/main.dart';

class LifecycleButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final gameSystem = Provider.of<GameSystem>(context, listen: true);
    final lifeCycleButtons = _getLifeCycleButtons(gameSystem);
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ...lifeCycleButtons,
          SizedBox(width: 20),
          Text(
            "Score: ${gameSystem.score}",
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }

  List<RaisedButton> _getLifeCycleButtons(GameSystem gameSystem) {
    final gameStatus = gameSystem.gameStatus;

    if (gameStatus == GameStatus.gameOver) {
      return [
        RaisedButton.icon(
          label: Text("Replay"),
          icon: Icon(Icons.replay),
          onPressed: gameSystem.replay,
        )
      ];
    }

    final List<RaisedButton> lifeCycleButtons = [];
    if (gameStatus == GameStatus.play) {
      lifeCycleButtons.add(RaisedButton.icon(
        label: Text("Pause"),
        icon: Icon(Icons.pause),
        onPressed: gameSystem.pause,
      ));
    } else {
      lifeCycleButtons.add(RaisedButton.icon(
        label: Text("Play"),
        icon: Icon(Icons.play_arrow),
        onPressed: gameSystem.play,
      ));
    }
    lifeCycleButtons.add(RaisedButton.icon(
      label: Text("Stop"),
      icon: Icon(Icons.stop),
      onPressed: gameSystem.stop,
    ));

    return lifeCycleButtons;
  }
}

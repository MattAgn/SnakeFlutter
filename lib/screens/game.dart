import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snake_game/ecs/systems/main.dart';
import 'package:snake_game/widgets/options_dialog.dart';
import 'package:snake_game/widgets/arrow_controls.dart';
import 'package:snake_game/widgets/game_board.dart';
import 'package:snake_game/widgets/keyboard_controls.dart';
import 'package:snake_game/widgets/lifecycle_button.dart';

class Game extends StatelessWidget {
  final int levelNumber;

  Game({this.levelNumber});

  Future<void> _showOptionsDialog(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return OptionsDialog();
        });
  }

  _renderWebGame() {
    return KeyboardControls(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[GameBoard(), LifecycleButtons()],
      ),
    );
  }

  _renderMobileGame() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[GameBoard(), ArrowControls(), LifecycleButtons()],
    );
  }

  @override
  Widget build(BuildContext context) {
    final gameSystem = Provider.of<GameSystem>(context);
    if (levelNumber != null) {
      gameSystem.levelNumber = levelNumber;
    }
    // TODO: put below code at the initialization of the widget
    if (gameSystem.entities == null) {
      Future.delayed(const Duration(milliseconds: 500), () {
        gameSystem.reset();
      });
    }

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text(levelNumber != null ? "Level $levelNumber" : "Game"),
        actions: levelNumber == null
            ? <Widget>[
                IconButton(
                  onPressed: () {
                    _showOptionsDialog(context);
                    gameSystem.pause();
                  },
                  icon: Icon(Icons.settings),
                )
              ]
            : null,
      ),
      body: SafeArea(
        child: kIsWeb ? _renderWebGame() : _renderMobileGame(),
      ),
    );
  }
}

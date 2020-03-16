import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snake_game/ecs/systems/main.dart';
import 'package:snake_game/widgets/arrow_controls.dart';
import 'package:snake_game/widgets/game_board.dart';
import 'package:snake_game/widgets/keyboard_controls.dart';
import 'package:snake_game/widgets/lifecycle_button.dart';

class Game extends StatelessWidget {
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
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text("Game"),
      ),
      body: SafeArea(
        child: ChangeNotifierProvider<GameSystem>(
            create: (context) => GameSystem(),
            child: kIsWeb ? _renderWebGame() : _renderMobileGame()),
      ),
    );
  }
}

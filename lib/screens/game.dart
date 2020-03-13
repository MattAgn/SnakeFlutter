import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snake_game/ecs/systems/main.dart';
import 'package:snake_game/widgets/controls.dart';
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
            children: <Widget>[GameBoard(), Controls(), LifecycleButtons()],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:snake_game/ecs/systems/main.dart';
import 'package:snake_game/screens/game_board.dart';
import 'package:snake_game/screens/landing.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GameSystem gameSystem = GameSystem();
    gameSystem.init();
    return MaterialApp(
      title: 'Snake game',
      theme: ThemeData(
        primaryColor: Colors.green,
      ),
      initialRoute: "/game_board",
      routes: {
        "/": (context) => Landing(),
        "/game_board": (context) => GameBoard()
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:snake_game/screens/game.dart';
import 'package:snake_game/screens/landing.dart';
import 'package:snake_game/screens/options.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Snake game',
      theme: ThemeData(
        primaryColor: Colors.green,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => Landing(),
        "/game": (context) => Game(),
        "/options": (context) => Options(),
      },
    );
  }
}

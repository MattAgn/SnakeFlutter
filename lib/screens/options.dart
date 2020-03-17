import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snake_game/ecs/systems/main.dart';
import 'package:snake_game/widgets/toggle_button.dart';

class Options extends StatelessWidget {
  final List<bool> isSelected = [false, true];
  final int nbWalls = 0;
  final int nbPortals = 0;

  @override
  Widget build(BuildContext context) {
    final gameSystem = Provider.of<GameSystem>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: Text("Options"),
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text("Surround board with"),
                  SizedBox(height: 5),
                  ToggleButtons(
                    children: <Widget>[
                      ToggleButton(title: "walls"),
                      ToggleButton(title: "portals"),
                    ],
                    isSelected: [true, false],
                    onPressed: (int s) {},
                  ),
                ],
              ),
              SizedBox(height: 60),
              Column(
                children: <Widget>[
                  Text(
                      "Number of random walls: ${gameSystem.optionsSystem.nbRandomWalls}"),
                  SizedBox(height: 5),
                  Slider(
                    value: gameSystem.optionsSystem.nbRandomWalls.toDouble(),
                    max: 20,
                    min: 0,
                    onChanged: (value) =>
                        gameSystem.nbRandomWalls = value.toInt(),
                  ),
                ],
              ),
              SizedBox(height: 60),
              Column(
                children: <Widget>[
                  Text(
                      "Number of random portals: ${gameSystem.optionsSystem.nbRandomPortals}"),
                  SizedBox(height: 5),
                  Slider(
                    value: gameSystem.optionsSystem.nbRandomPortals.toDouble(),
                    max: 20,
                    min: 0,
                    onChanged: (value) =>
                        gameSystem.nbRandomPortals = value.toInt(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

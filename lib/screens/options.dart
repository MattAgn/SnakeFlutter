import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snake_game/ecs/systems/main.dart';
import 'package:snake_game/ecs/systems/options.dart';
import 'package:snake_game/widgets/toggle_button.dart';

class Options extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final OptionsSystem optionsSystem =
        Provider.of<GameSystem>(context, listen: true).optionsSystem;

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
                      ToggleButton(title: "portals"),
                      ToggleButton(title: "walls"),
                    ],
                    isSelected:
                        optionsSystem.surroundingBoardEntityTypesSelected,
                    onPressed: optionsSystem.selectSurroundingEntityType,
                  ),
                ],
              ),
              SizedBox(height: 60),
              Column(
                children: <Widget>[
                  Text(
                      "Number of random walls: ${optionsSystem.nbRandomWalls}"),
                  SizedBox(height: 5),
                  Slider(
                    value: optionsSystem.nbRandomWalls.toDouble(),
                    max: OptionsSystem.maxNbRandomWalls.toDouble(),
                    min: OptionsSystem.minNbRandomWalls.toDouble(),
                    onChanged: (value) =>
                        optionsSystem.nbRandomWalls = value.toInt(),
                  ),
                ],
              ),
              SizedBox(height: 60),
              Column(
                children: <Widget>[
                  Text(
                      "Number of random portals: ${optionsSystem.nbRandomPortals}"),
                  SizedBox(height: 5),
                  Slider(
                    value: optionsSystem.nbRandomPortals.toDouble(),
                    max: OptionsSystem.maxNbRandomPortals.toDouble(),
                    min: OptionsSystem.minNbRandomPortals.toDouble(),
                    onChanged: (value) =>
                        optionsSystem.nbRandomPortals = value.toInt(),
                  ),
                ],
              ),
              SizedBox(height: 60),
              Column(
                children: <Widget>[
                  Text("Game Speed: ${optionsSystem.gameSpeedDisplayed}"),
                  SizedBox(height: 5),
                  Slider(
                    value: optionsSystem.gameSpeedDisplayed,
                    max: OptionsSystem.maxGameSpeedDisplayed,
                    min: OptionsSystem.minGameSpeedDisplayed,
                    onChanged: (value) =>
                        optionsSystem.gameSpeedDisplayed = value,
                  ),
                ],
              ),
              SizedBox(height: 60),
              Column(
                children: <Widget>[
                  Text("Board size: ${optionsSystem.boardSize}"),
                  SizedBox(height: 5),
                  Slider(
                    value: optionsSystem.boardSize.toDouble(),
                    max: OptionsSystem.maxBoardSize.toDouble(),
                    min: OptionsSystem.minBoardSize.toDouble(),
                    onChanged: (value) =>
                        optionsSystem.boardSize = value.toInt(),
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

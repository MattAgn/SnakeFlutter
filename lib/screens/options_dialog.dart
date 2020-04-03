import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snake_game/ecs/systems/main.dart';
import 'package:snake_game/ecs/systems/options.dart';
import 'package:snake_game/widgets/toggle_button.dart';

class OptionsDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final OptionsSystem optionsSystem =
        Provider.of<GameSystem>(context, listen: true).optionsSystem;

    return Center(
      child: SizedBox(
        width: 700.0,
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Container(
            padding: EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Options",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
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
                RaisedButton(
                  child: Text("OK"),
                  onPressed: () => Navigator.pop(context),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

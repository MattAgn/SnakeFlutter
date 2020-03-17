import 'package:flutter/material.dart';
import 'package:snake_game/widgets/toggle_button.dart';

class Options extends StatefulWidget {
  @override
  _OptionsState createState() => _OptionsState();
}

class _OptionsState extends State<Options> {
  List<bool> isSelected = [false, true];
  int nbWalls = 0;
  int nbPortals = 0;

  onPressSurroundingBoardOptions(int index) {
    setState(() {
      for (int buttonIndex = 0;
          buttonIndex < isSelected.length;
          buttonIndex++) {
        if (buttonIndex == index) {
          isSelected[buttonIndex] = true;
        } else {
          isSelected[buttonIndex] = false;
        }
      }
    });
  }

  onChangeNbRandomPortals(value) {
    setState(() {
      nbPortals = value.toInt();
    });
  }

  onChangeNbRandomWalls(value) {
    setState(() {
      nbWalls = value.toInt();
    });
  }

  @override
  Widget build(BuildContext context) {
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
                    isSelected: isSelected,
                    onPressed: onPressSurroundingBoardOptions,
                  ),
                ],
              ),
              SizedBox(height: 60),
              Column(
                children: <Widget>[
                  Text("Number of random walls: $nbWalls"),
                  SizedBox(height: 5),
                  Slider(
                    value: nbWalls.toDouble(),
                    max: 20,
                    min: 0,
                    onChanged: onChangeNbRandomWalls,
                  ),
                ],
              ),
              SizedBox(height: 60),
              Column(
                children: <Widget>[
                  Text("Number of random portals: $nbPortals"),
                  SizedBox(height: 5),
                  Slider(
                    value: nbPortals.toDouble(),
                    max: 20,
                    min: 0,
                    onChanged: onChangeNbRandomPortals,
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

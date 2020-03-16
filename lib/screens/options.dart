import 'package:flutter/material.dart';

class Options extends StatefulWidget {
  @override
  _OptionsState createState() => _OptionsState();
}

class _OptionsState extends State<Options> {
  List<bool> isSelected = [false, true];
  int nbWalls = 0;
  int nbPortals = 0;

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
                    children: <Widget>[Text("Walls"), Text("Portals")],
                    isSelected: isSelected,
                    onPressed: (int index) {
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
                    },
                  ),
                ],
              ),
              SizedBox(height: 40),
              Column(
                children: <Widget>[
                  Text("Number of walls"),
                  SizedBox(height: 5),
                  Slider(
                    value: nbWalls.toDouble(),
                    max: 20,
                    min: 0,
                    onChanged: (value) => setState(() {
                      nbWalls = value.toInt();
                    }),
                  ),
                  Text(nbWalls.toString())
                ],
              ),
              SizedBox(height: 40),
              Column(
                children: <Widget>[
                  Text("Number of portals"),
                  SizedBox(height: 5),
                  Slider(
                    value: nbPortals.toDouble(),
                    max: 20,
                    min: 0,
                    onChanged: (value) => setState(() {
                      nbPortals = value.toInt();
                    }),
                  ),
                  Text(nbPortals.toString())
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

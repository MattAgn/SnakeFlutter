import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snake_game/ecs/components/controller.dart';
import 'package:snake_game/ecs/systems/main.dart';
import 'package:snake_game/widgets/control_button.dart';

class Controls extends StatelessWidget {
  const Controls({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final gameSystem = Provider.of<GameSystem>(context, listen: false);

    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Expanded(flex: 5, child: SizedBox()),
                  Expanded(
                    flex: 8,
                    child: ControlButton(
                      child: Icon(Icons.arrow_back),
                      onPress: () {
                        gameSystem.direction = Direction
                            .left; // la direction des controls, c'est plus celle du snake que du game non? // fuadrait des getters sur nos entités direct en vrai
                      },
                    ),
                  ),
                  Expanded(flex: 5, child: SizedBox()),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: ControlButton(
                      child: Icon(Icons.arrow_upward),
                      onPress: () {
                        gameSystem.direction = Direction.up;
                      },
                    ),
                  ),
                  Expanded(flex: 1, child: SizedBox()),
                  Expanded(
                    flex: 4,
                    child: ControlButton(
                      child: Icon(Icons.arrow_downward),
                      onPress: () {
                        gameSystem.direction = Direction.down;
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(flex: 5, child: SizedBox()),
                  Expanded(
                    flex: 8,
                    child: ControlButton(
                      child: Icon(Icons.arrow_forward),
                      onPress: () {
                        gameSystem.direction = Direction.rigth;
                      },
                    ),
                  ),
                  Expanded(flex: 5, child: SizedBox()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

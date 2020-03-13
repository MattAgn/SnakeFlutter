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
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ControlButton(
              text: "<",
              onPress: () {
                gameSystem.direction = Direction.left;
              },
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  ControlButton(
                    text: "^",
                    onPress: () {
                      gameSystem.direction = Direction.up;
                    },
                  ),
                  ControlButton(
                    text: "v",
                    onPress: () {
                      gameSystem.direction = Direction.down;
                    },
                  ),
                ],
              ),
            ),
            ControlButton(
              text: ">",
              onPress: () {
                gameSystem.direction = Direction.rigth;
              },
            ),
          ],
        ),
      ),
    );
  }
}

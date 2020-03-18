import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:snake_game/ecs/components/controller.dart';
import 'package:snake_game/ecs/systems/main.dart';

const ARROW_RIGHT_KEY_ID = 0x10007004f;
const ARROW_LEFT_KEY_ID = 0x100070050;
const ARROW_UP_KEY_ID = 0x100070052;
const ARROW_DOWN_KEY_ID = 0x100070051;
const SPACE_KEY_ID = 0x00000020;
const ENTER_KEY_ID = 0x100070028;

class KeyboardControls extends StatelessWidget {
  final Widget child;

  KeyboardControls({this.child});

  Function _onKey(BuildContext context) {
    final gameSystem = Provider.of<GameSystem>(context, listen: false);

    return (RawKeyEvent value) {
      print(value);
      if (value is RawKeyDownEvent) {
        switch (value.data.logicalKey.keyId) {
          case ARROW_UP_KEY_ID:
            gameSystem.direction = Direction.up;
            break;
          case ARROW_DOWN_KEY_ID:
            gameSystem.direction = Direction.down;
            break;
          case ARROW_RIGHT_KEY_ID:
            gameSystem.direction = Direction.right;
            break;
          case ARROW_LEFT_KEY_ID:
            gameSystem.direction = Direction.left;
            break;
          case SPACE_KEY_ID:
            gameSystem.playOrPause();
            break;
          case ENTER_KEY_ID:
            gameSystem.stop();
            break;
        }
      }
    };
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      onKey: _onKey(context),
      child: this.child,
      focusNode: FocusNode(),
      autofocus: true,
    );
  }
}

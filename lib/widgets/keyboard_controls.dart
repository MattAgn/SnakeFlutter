import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:snake_game/ecs/components/controller.dart';
import 'package:snake_game/ecs/systems/main.dart';

class KeyboardControls extends StatelessWidget {
  final Widget child;

  KeyboardControls({this.child});

  Function _onKey(BuildContext context) {
    final gameSystem = Provider.of<GameSystem>(context, listen: false);

    return (RawKeyEvent value) {
      if (value is RawKeyDownEvent) {
        switch (value.data.logicalKey.keyId) {
          case 0x100070052:
            gameSystem.direction = Direction.up;
            break;
          case 0x100070051:
            gameSystem.direction = Direction.down;
            break;
          case 0x10007004f:
            gameSystem.direction = Direction.right;
            break;
          case 0x100070050:
            gameSystem.direction = Direction.left;
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

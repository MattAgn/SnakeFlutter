import 'package:flutter/material.dart';
import 'package:snake_game/ecs/components/controllable.dart';
import 'package:snake_game/ecs/components/eater.dart';
import 'package:snake_game/ecs/components/movable.dart';
import 'package:snake_game/ecs/components/not_eatabable.dart';
import 'package:snake_game/ecs/components/position.dart';
import 'package:snake_game/ecs/entities/entity.dart';

class Snake extends Entity {
  Movable movable;
  Controllable controllable;
  Positions positions;
  NotEatable notEatble;
  Eater eater;
  static final Positions defaultPosition =
      Positions(coordinatesList: [Coordinates(x: 0, y: 0)]);

  Snake({@required this.movable, @required this.positions});

  @override
  getComponentTypes() {
    return [Movable, Controllable, Positions, NotEatable, Eater];
  }
}

import 'package:flutter/material.dart';
import 'package:snake_game/ecs/components/controllable.dart';
import 'package:snake_game/ecs/components/eater.dart';
import 'package:snake_game/ecs/components/movable.dart';
import 'package:snake_game/ecs/components/not_eatbable.dart';
import 'package:snake_game/ecs/components/position.dart';
import 'package:snake_game/ecs/entities/entity.dart';

class Snake extends Entity {
  Movable movable;
  Controllable controllable;
  List<Position> positions;
  NotEatble notEatble;
  Eater eater;
  static final Position defaultPosition =
      Position(coordinates: Coordinates(x: 0, y: 0));

  Snake({@required this.movable, @required this.positions});
}

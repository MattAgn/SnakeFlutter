import 'package:flutter/material.dart';
import 'package:snake_game/ecs/components/position.dart';
import 'package:snake_game/ecs/entities/entity.dart';

class Board extends Entity {
  List<Position> positions;

  Board({@required this.positions}) : assert(positions != null);

  @override
  getComponentTypes() {
    return [Position];
  }
}

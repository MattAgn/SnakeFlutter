import 'package:flutter/material.dart';
import 'package:snake_game/ecs/components/eater.dart';
import 'package:snake_game/ecs/components/position.dart';

class Snake {
  List<Position> positions;
  Eater eater;

  Snake({@required this.positions, @required this.eater})
      : assert(positions != null),
        assert(eater != null);
}

import 'package:flutter/material.dart';
import 'package:snake_game/ecs/components/eatable.dart';
import 'package:snake_game/ecs/components/position.dart';
import 'package:snake_game/ecs/entities/entity.dart';

class Apple extends Entity {
  Positions positions;
  Eatable eatable;

  Apple({@required this.positions}) : assert(positions != null);

  @override
  getComponentTypes() {
    return [Positions, Eatable];
  }
}

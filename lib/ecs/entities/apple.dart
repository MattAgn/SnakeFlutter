import 'package:flutter/material.dart';
import 'package:snake_game/ecs/components/eatable.dart';
import 'package:snake_game/ecs/components/position.dart';
import 'package:snake_game/ecs/entities/entity.dart';

class Apple extends Entity {
  Position position;
  Eatable eatable;

  Apple({@required this.position}) : assert(position != null);

  @override
  getComponentTypes() {
    return [Position, Eatable];
  }
}

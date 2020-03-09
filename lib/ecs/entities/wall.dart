import 'package:flutter/material.dart';
import 'package:snake_game/ecs/components/not_eatabable.dart';
import 'package:snake_game/ecs/components/position.dart';
import 'package:snake_game/ecs/entities/entity.dart';

class Wall extends Entity {
  NotEatable notEatable;
  Positions positions;

  Wall({@required this.positions}) : assert(positions = null);

  @override
  getComponentTypes() {
    return [NotEatable, Positions];
  }
}

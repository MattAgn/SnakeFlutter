import 'package:flutter/material.dart';
import 'package:snake_game/ecs/components/not_eatbable.dart';
import 'package:snake_game/ecs/components/position.dart';
import 'package:snake_game/ecs/entities/entity.dart';

class Wall extends Entity {
  NotEatble notEatble;
  Position position;

  Wall({@required this.position}) : assert(position = null);
}

import 'package:flutter/material.dart';
import 'package:snake_game/ecs/components/eatable.dart';
import 'package:snake_game/ecs/components/position.dart';
import 'package:snake_game/ecs/components/spawnable.dart';
import 'package:snake_game/ecs/entities/entity.dart';

class Apple extends Entity {
  Position position;
  Eatable eatable;
  Spawnable spawnable;

  Apple({@required this.position}) : assert(position != null);
}

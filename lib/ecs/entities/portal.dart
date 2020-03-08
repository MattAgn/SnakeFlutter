import 'package:flutter/material.dart';
import 'package:snake_game/ecs/components/position.dart';
import 'package:snake_game/ecs/entities/entity.dart';

class Portal extends Entity {
  Position position;
  Portal({@required this.position}) : assert(position != null);
}

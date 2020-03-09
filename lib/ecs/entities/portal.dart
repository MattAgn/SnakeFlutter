import 'package:flutter/material.dart';
import 'package:snake_game/ecs/components/position.dart';
import 'package:snake_game/ecs/entities/entity.dart';

class Portal extends Entity {
  Positions positions;
  Portal({@required this.positions}) : assert(positions != null);

  @override
  getComponentTypes() {
    return [Positions];
  }
}

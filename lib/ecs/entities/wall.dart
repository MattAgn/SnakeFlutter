import 'package:flutter/material.dart';

import 'package:snake_game/ecs/components/not_eatable.dart';
import 'package:snake_game/ecs/components/position.dart';
import 'package:snake_game/ecs/components/renderable.dart';
import 'package:snake_game/ecs/entities/entity.dart';

class WallEntity extends Entity
    with NotEatableComponent, LeadPositionComponent, RenderableComponent {
  WallEntity(Coordinates initialLeadPosition) {
    WallEntity.numberOfWall++;
    this.wallNumber = WallEntity.numberOfWall;

    this.leadPosition = initialLeadPosition;

    paint = (double boardSquareSize) {
      return [
        PositionedOnBoard(
          key: Key('apple_$wallNumber'),
          boardSquareSize: boardSquareSize,
          origin: leadPosition,
          child: Container(color: Colors.orange),
        )
      ];
    };
  }

  int wallNumber;

  static int numberOfWall = 0;
}

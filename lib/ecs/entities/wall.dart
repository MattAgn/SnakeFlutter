import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

import 'package:snake_game/ecs/components/not_eatable.dart';
import 'package:snake_game/ecs/components/position.dart';
import 'package:snake_game/ecs/components/renderable.dart';
import 'package:snake_game/ecs/entities/entity.dart';

class WallEntity extends Entity
    with NotEatableComponent, LeadPositionComponent, RenderableComponent {
  WallEntity(Coordinates initialLeadPosition, int boardSize) {
    WallEntity.numberOfWalls++;
    this.wallNumber = WallEntity.numberOfWalls;

    this.leadPosition = initialLeadPosition;

    paint = (double boardSquareSize) {
      double wallRotation = 0;
      if (leadPosition.x == 0 || leadPosition.x == boardSize - 1) {
        if (leadPosition.y == 0 || leadPosition.y == boardSize - 1) {
          wallRotation = leadPosition.x != leadPosition.y ? pi / 4 : -pi / 4;
        } else {
          wallRotation = pi / 2;
        }
      }
      return [
        PositionedOnBoard(
          key: Key('wall_$wallNumber'),
          origin: leadPosition,
          boardSquareSize: boardSquareSize,
          angle: wallRotation,
          scale: 1,
          child: FlareActor('assets/rive/wall.flr'),
        ),
      ];
    };
  }

  int wallNumber;

  static int numberOfWalls = 0;
}

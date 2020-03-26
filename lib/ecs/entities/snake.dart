import 'dart:math';
import 'package:flare_flutter/flare_actor.dart';

import 'package:flutter/material.dart';
import 'package:snake_game/ecs/components/body.dart';
import 'package:snake_game/ecs/components/controllable.dart';
import 'package:snake_game/ecs/components/eater.dart';
import 'package:snake_game/ecs/components/movable.dart';
import 'package:snake_game/ecs/components/not_eatable.dart';
import 'package:snake_game/ecs/components/position.dart';
import 'package:snake_game/ecs/components/renderable.dart';
import 'package:snake_game/ecs/entities/entity.dart';

class SnakeEntity extends Entity
    with
        MovableComponent,
        BodyComponent,
        ControllableComponent,
        LeadPositionComponent,
        NotEatableComponent,
        EaterComponent,
        RenderableComponent {
  SnakeEntity(Coordinates initialLeadPosition, Speed speed) {
    this.body = [];
    this.leadPosition = initialLeadPosition;

    this.paint = (double boardSquareSize) {
      final List<PositionedOnBoard> snakeElements = [];

      for (int bodyPartNumber = 0;
          bodyPartNumber < body.length;
          bodyPartNumber++) {
        final bodyPartPosition = body[bodyPartNumber];
        snakeElements.add(
          PositionedOnBoard(
            key: Key('snake_body_$bodyPartNumber'),
            origin: bodyPartPosition,
            boardSquareSize: boardSquareSize,
            child: Container(color: Colors.green),
          ),
        );
      }

      snakeElements.add(
        PositionedOnBoard(
          key: Key('snake_head'),
          origin: leadPosition,
          boardSquareSize: boardSquareSize,
          angle: rotation,
          scale: 1.5,
          child: FlareActor('assets/rive/snake_head.flr'),
        ),
      );

      return snakeElements;
    };
  }

  double get rotation {
    return atan2(speed.dy, speed.dx) - pi / 2;
  }
}

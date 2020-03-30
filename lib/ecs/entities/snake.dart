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

      // body
      for (int bodyPartNumber = 0;
          bodyPartNumber < body.length;
          bodyPartNumber++) {
        final bodyPartPosition = body[bodyPartNumber];
        final previousBodyPartPosition =
            bodyPartNumber == 0 ? leadPosition : body[bodyPartNumber - 1];
        final nextBodyPartPosition =
            bodyPartNumber == body.length - 1 ? null : body[bodyPartNumber + 1];
        String bodyAsset;
        double bodyAngle = 0;

        if (nextBodyPartPosition == null) {
          bodyAsset = 'snake_body_tail';
          if (bodyPartPosition.x == previousBodyPartPosition.x) {
            // x
            // x
            bodyAngle =
                bodyPartPosition.y < previousBodyPartPosition.y ? 0 : pi;
          } else if (bodyPartPosition.y == previousBodyPartPosition.y) {
            // x x
            bodyAngle = bodyPartPosition.x < previousBodyPartPosition.x
                ? -pi / 2
                : pi / 2;
          }
        } else if (bodyPartPosition.x == previousBodyPartPosition.x &&
            bodyPartPosition.x == nextBodyPartPosition.x) {
          // x
          // x
          // x
          bodyAsset = 'snake_body_straight';
          bodyAngle = 0;
        } else if (bodyPartPosition.y == previousBodyPartPosition.y &&
            bodyPartPosition.y == nextBodyPartPosition.y) {
          // x x x
          bodyAsset = 'snake_body_straight';
          bodyAngle = pi / 2;
        } else {
          bodyAsset = 'snake_body_curve';
          if (previousBodyPartPosition.x == bodyPartPosition.x &&
                  previousBodyPartPosition.y > bodyPartPosition.y &&
                  nextBodyPartPosition.x < bodyPartPosition.x ||
              previousBodyPartPosition.y == bodyPartPosition.y &&
                  previousBodyPartPosition.x < bodyPartPosition.x &&
                  nextBodyPartPosition.y > bodyPartPosition.y) {
            // x x
            //   x
            bodyAngle = 0;
          } else if (previousBodyPartPosition.x == bodyPartPosition.x &&
                  previousBodyPartPosition.y < bodyPartPosition.y &&
                  nextBodyPartPosition.x > bodyPartPosition.x ||
              previousBodyPartPosition.y == bodyPartPosition.y &&
                  previousBodyPartPosition.x > bodyPartPosition.x &&
                  nextBodyPartPosition.y < bodyPartPosition.y) {
            // x
            // x x
            bodyAngle = pi;
          } else if (previousBodyPartPosition.x == bodyPartPosition.x &&
                  previousBodyPartPosition.y > bodyPartPosition.y &&
                  nextBodyPartPosition.x > bodyPartPosition.x ||
              previousBodyPartPosition.y == bodyPartPosition.y &&
                  previousBodyPartPosition.x > bodyPartPosition.x &&
                  nextBodyPartPosition.y > bodyPartPosition.y) {
            // x x
            // x
            bodyAngle = -pi / 2;
          } else if (previousBodyPartPosition.x == bodyPartPosition.x &&
                  previousBodyPartPosition.y < bodyPartPosition.y &&
                  nextBodyPartPosition.x < bodyPartPosition.x ||
              previousBodyPartPosition.y == bodyPartPosition.y &&
                  previousBodyPartPosition.x < bodyPartPosition.x &&
                  nextBodyPartPosition.y < bodyPartPosition.y) {
            //   x
            // x x
            bodyAngle = pi / 2;
          }
        }
        snakeElements.add(
          PositionedOnBoard(
            key: Key('snake_body_$bodyPartNumber'),
            origin: bodyPartPosition,
            boardSquareSize: boardSquareSize,
            angle: bodyAngle,
            scale: 1.05,
            child: FlareActor('assets/rive/$bodyAsset.flr'),
          ),
        );
      }

      // head
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

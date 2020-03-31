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
      final paintedSnakeHead = _paintHead(boardSquareSize);
      final paintedSnakeTail = _paintTail(boardSquareSize);
      final paintedSnakeBody = _paintBody(boardSquareSize);

      return [...paintedSnakeBody, paintedSnakeTail, paintedSnakeHead];
    };
  }

  PositionedOnBoard _paintHead(double boardSquareSize) {
    return PositionedOnBoard(
      key: Key('snake_head'),
      origin: leadPosition,
      boardSquareSize: boardSquareSize,
      angle: rotation,
      scale: 1.5,
      child: FlareActor('assets/rive/snake_head.flr'),
    );
  }

  PositionedOnBoard _paintTail(double boardSquareSize) {
    final tail = body.last;
    final bodyLength = body.length;
    final previousBodyPart =
        bodyLength == 1 ? leadPosition : body[bodyLength - 2];

    double tailRotation = 0;
    if (tail.x == previousBodyPart.x) {
      // x
      // x
      tailRotation = tail.y < previousBodyPart.y ? 0 : pi;
    } else if (tail.y == previousBodyPart.y) {
      // x x
      tailRotation = tail.x < previousBodyPart.x ? -pi / 2 : pi / 2;
    }

    return PositionedOnBoard(
      key: Key('snake_body_$bodyLength'),
      origin: tail,
      boardSquareSize: boardSquareSize,
      angle: tailRotation,
      scale: 1.05,
      child: FlareActor('assets/rive/snake_body_tail.flr'),
    );
  }

  List<PositionedOnBoard> _paintBody(double boardSquareSize) {
    final List<PositionedOnBoard> paintedBodyParts = [];

    for (int bodyPartNumber = 0;
        bodyPartNumber < body.length - 1;
        bodyPartNumber++) {
      final bodyPart = body[bodyPartNumber];
      final previousBodyPart =
          bodyPartNumber == 0 ? leadPosition : body[bodyPartNumber - 1];
      final nextBodyPart = body[bodyPartNumber + 1];

      String bodyAssetName;
      double bodyPartRotation = 0;
      if (bodyPart.x == previousBodyPart.x && bodyPart.x == nextBodyPart.x) {
        // x
        // x
        // x
        bodyAssetName = 'snake_body_straight';
        bodyPartRotation = 0;
      } else if (bodyPart.y == previousBodyPart.y &&
          bodyPart.y == nextBodyPart.y) {
        // x x x
        bodyAssetName = 'snake_body_straight';
        bodyPartRotation = pi / 2;
      } else {
        bodyAssetName = 'snake_body_curve';
        if (previousBodyPart.x == bodyPart.x &&
                previousBodyPart.y > bodyPart.y &&
                nextBodyPart.x < bodyPart.x ||
            previousBodyPart.y == bodyPart.y &&
                previousBodyPart.x < bodyPart.x &&
                nextBodyPart.y > bodyPart.y) {
          // x x
          //   x
          bodyPartRotation = 0;
        } else if (previousBodyPart.x == bodyPart.x &&
                previousBodyPart.y < bodyPart.y &&
                nextBodyPart.x > bodyPart.x ||
            previousBodyPart.y == bodyPart.y &&
                previousBodyPart.x > bodyPart.x &&
                nextBodyPart.y < bodyPart.y) {
          // x
          // x x
          bodyPartRotation = pi;
        } else if (previousBodyPart.x == bodyPart.x &&
                previousBodyPart.y > bodyPart.y &&
                nextBodyPart.x > bodyPart.x ||
            previousBodyPart.y == bodyPart.y &&
                previousBodyPart.x > bodyPart.x &&
                nextBodyPart.y > bodyPart.y) {
          // x x
          // x
          bodyPartRotation = -pi / 2;
        } else if (previousBodyPart.x == bodyPart.x &&
                previousBodyPart.y < bodyPart.y &&
                nextBodyPart.x < bodyPart.x ||
            previousBodyPart.y == bodyPart.y &&
                previousBodyPart.x < bodyPart.x &&
                nextBodyPart.y < bodyPart.y) {
          //   x
          // x x
          bodyPartRotation = pi / 2;
        }
      }

      paintedBodyParts.add(PositionedOnBoard(
        key: Key('snake_body_$bodyPartNumber'),
        origin: bodyPart,
        boardSquareSize: boardSquareSize,
        angle: bodyPartRotation,
        scale: 1.05,
        child: FlareActor('assets/rive/$bodyAssetName.flr'),
      ));
    }

    return paintedBodyParts;
  }

  double get rotation {
    return atan2(speed.dy, speed.dx) - pi / 2;
  }
}

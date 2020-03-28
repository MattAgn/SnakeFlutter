import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

import 'package:snake_game/ecs/components/eatable.dart';
import 'package:snake_game/ecs/components/position.dart';
import 'package:snake_game/ecs/components/renderable.dart';
import 'package:snake_game/ecs/components/spawnable.dart';
import 'package:snake_game/ecs/entities/entity.dart';

class AppleEntity extends Entity
    with
        LeadPositionComponent,
        EatableComponent,
        SpanwableComponent,
        RenderableComponent {
  AppleEntity(Coordinates initialApplePosition) {
    AppleEntity.numberOfApples++;
    this.appleNumber = AppleEntity.numberOfApples;

    leadPosition = initialApplePosition;

    paint = (double boardSquareSize) {
      return [
        PositionedOnBoard(
          key: Key('apple_$appleNumber'),
          boardSquareSize: boardSquareSize,
          origin: leadPosition,
          scale: 1.5,
          child: FlareActor('assets/rive/apple.flr'),
        )
      ];
    };
  }

  int appleNumber;

  static int numberOfApples = 0;
}

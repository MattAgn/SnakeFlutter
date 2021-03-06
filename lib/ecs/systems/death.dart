import 'package:flutter/material.dart';
import 'package:snake_game/ecs/components/body.dart';
import 'package:snake_game/ecs/components/eater.dart';
import 'package:snake_game/ecs/components/not_eatable.dart';
import 'package:snake_game/ecs/components/position.dart';
import 'package:snake_game/ecs/entities/entity.dart';
import 'package:snake_game/ecs/entities/snake.dart';
import 'package:snake_game/ecs/systems/options.dart';
import 'package:snake_game/ecs/systems/system.dart';

class DeathSystem extends System {
  handleDeadEntities(List<Entity> entities, VoidCallback handleGameOver) {
    final eaterEntities = this.getEntitiesByComponents<EaterComponent,
        LeadPositionComponent, EaterComponent>(entities);
    eaterEntities.forEach((eater) {
      if (eater.isDead) {
        if (eater is SnakeEntity) {
          handleGameOver();
        }
      }
    });
  }

  @override
  handleEntities(entities, [OptionsSystem options]) {
    final notEatableEntities = this.getEntitiesByComponents<NotEatableComponent,
        LeadPositionComponent, dynamic>(entities);
    final eaterEntities = this.getEntitiesByComponents<EaterComponent,
        LeadPositionComponent, SnakeEntity>(entities);
    eaterEntities.forEach((eater) {
      notEatableEntities.forEach((notEatable) {
        if (notEatable is BodyComponent) {
          if (notEatable.body
              .any((bodyPosition) => bodyPosition.equal(eater.leadPosition))) {
            eater.isDead = true;
          }
        }
        if (notEatable != eater &&
            notEatable.leadPosition.equal(eater.leadPosition)) {
          eater.isDead = true;
        }
      });
    });
  }
}

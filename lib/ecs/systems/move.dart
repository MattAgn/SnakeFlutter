import 'package:snake_game/ecs/entities/snake.dart';
import 'package:snake_game/ecs/systems/system.dart';
import 'package:snake_game/ecs/components/movable.dart';
import 'package:snake_game/ecs/components/positions.dart';

class MoveSystem extends System {
  @override
  handleEntities(entities) {
    final movableEntities = this.getEntitiesByComponents<MovableComponent,
        LeadPositionComponent, SnakeEntity>(entities);

    movableEntities.forEach((entity) {
      final previousEntityHead = entity.leadPosition;
      final entitySpeed = entity.speed;

      final newEntityHead = Coordinates(
          x: previousEntityHead.x + entitySpeed.dx,
          y: previousEntityHead.y + entitySpeed.dy);

      final previousLeadPosition = entity.leadPosition;
      entity.body.insert(0, previousLeadPosition);
      if (!entity.hasEaten) {
        entity.body.removeLast();
      }
      entity.leadPosition = newEntityHead;

      print("--------");
      print("New x position: " + entity.leadPosition.toString());
      print("New y position: " + entity.leadPosition.toString());
    });
  }
}

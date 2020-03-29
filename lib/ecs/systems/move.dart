import 'package:snake_game/ecs/entities/snake.dart';
import 'package:snake_game/ecs/entities/portal.dart';
import 'package:snake_game/ecs/systems/options.dart';
import 'package:snake_game/ecs/systems/system.dart';
import 'package:snake_game/ecs/components/movable.dart';
import 'package:snake_game/ecs/components/position.dart';
import 'package:snake_game/ecs/components/exit_position.dart';

class MoveSystem extends System {
  @override
  handleEntities(entities, [OptionsSystem options]) {
    final movableEntities = this.getEntitiesByComponents<MovableComponent,
        LeadPositionComponent, SnakeEntity>(entities);
    final portals = this.getEntitiesByComponents<ExitPositionComponent,
        LeadPositionComponent, PortalEntity>(entities);

    movableEntities.forEach((entity) {
      if (!entity.isDead) {
        final previousEntityHead = entity.leadPosition;
        final entitySpeed = entity.speed;

        var newEntityHead = Coordinates(
            x: previousEntityHead.x + entitySpeed.dx,
            y: previousEntityHead.y + entitySpeed.dy);

        for (final portal in portals) {
          if (newEntityHead.equal(portal.leadPosition)) {
            newEntityHead = portal.exitPosition;
            break;
          }
        }

        final previousLeadPosition = entity.leadPosition;
        entity.body.insert(0, previousLeadPosition);
        if (!entity.hasEaten) {
          entity.body.removeLast();
        }
        entity.leadPosition = newEntityHead;

        // Debug logs
        // print("--------");
        // print("New x position: " + entity.leadPosition.x.toString());
        // print("New y position: " + entity.leadPosition.y.toString());
      }
    });
  }
}

import 'package:snake_game/ecs/components/eater.dart';
import 'package:snake_game/ecs/components/not_eatable.dart';
import 'package:snake_game/ecs/components/position.dart';
import 'package:snake_game/ecs/entities/entity.dart';
import 'package:snake_game/ecs/entities/snake.dart';
import 'package:snake_game/ecs/entities/wall.dart';
import 'package:snake_game/ecs/systems/system.dart';

class DeathSystem extends System {
  handleDeadEntities(
      List<Entity> entities, void Function(Entity) deadEntityHandler) {
    final eaterEntities = this.getEntitiesByComponents<EaterComponent,
        LeadPositionComponent, SnakeEntity>(entities);
    eaterEntities.forEach((eater) {
      if (eater.isDead) {
        deadEntityHandler(eater);
      }
    });
  }

  @override
  handleEntities(entities) {
    final notEatableEntities = this.getEntitiesByComponents<NotEatableComponent,
        LeadPositionComponent, WallEntity>(entities);
    final eaterEntities = this.getEntitiesByComponents<EaterComponent,
        LeadPositionComponent, SnakeEntity>(entities);
    eaterEntities.forEach((eater) {
      notEatableEntities.forEach((notEatable) {
        if (notEatable.leadPosition.equal(eater.leadPosition)) {
          eater.isDead = true;
        }
      });
    });
  }
}

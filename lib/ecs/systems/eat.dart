import 'package:snake_game/ecs/components/eatable.dart';
import 'package:snake_game/ecs/components/eater.dart';
import 'package:snake_game/ecs/components/positions.dart';
import 'package:snake_game/ecs/entities/apple.dart';
import 'package:snake_game/ecs/entities/snake.dart';
import 'package:snake_game/ecs/systems/system.dart';

class EatSystem extends System {
  @override
  handleEntities(entities) {
    final eatableEntities = this.getEntitiesByComponents<EatableComponent,
        LeadPositionComponent, AppleEntity>(entities);
    final eaterEntities = this.getEntitiesByComponents<EaterComponent,
        LeadPositionComponent, SnakeEntity>(entities);
    eaterEntities.forEach((eater) {
      eatableEntities.forEach((eatable) {
        if (eater.leadPosition.x == eatable.leadPosition.x &&
            eater.leadPosition.y == eatable.leadPosition.y) {
          eater.hasEaten = true;
        } else {
          eater.hasEaten = false;
        }
      });
    });
  }
}

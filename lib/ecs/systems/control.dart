import 'package:snake_game/ecs/components/controllable.dart';
import 'package:snake_game/ecs/components/controller.dart';
import 'package:snake_game/ecs/components/movable.dart';
import 'package:snake_game/ecs/entities/snake.dart';
import 'package:snake_game/ecs/systems/system.dart';
import 'package:snake_game/ecs/components/positions.dart';

class ControlSystem extends System {
  @override
  handleEntities(entities) {
    final controllerEntities =
        this.getEntitiesByComponent<ControllerComponent>(entities);
    final controllableEntities = this.getEntitiesByComponents<
        ControllableComponent, MovableComponent, SnakeEntity>(entities);

    controllerEntities.forEach((controllerEntity) {
      controllableEntities.forEach((controllableEntity) {
        controllableEntity.movable.direction = controllerEntity.direction;
      });
    });
  }
}

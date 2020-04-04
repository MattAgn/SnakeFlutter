import 'package:snake_game/ecs/components/controllable.dart';
import 'package:snake_game/ecs/components/controller.dart';
import 'package:snake_game/ecs/components/movable.dart';
import 'package:snake_game/ecs/entities/controls.dart';
import 'package:snake_game/ecs/entities/snake.dart';
import 'package:snake_game/ecs/systems/options.dart';
import 'package:snake_game/ecs/systems/system.dart';

class ControlSystem extends System {
  @override
  handleEntities(entities, [OptionsSystem options]) {
    final controllerEntities = this
        .getEntitiesByComponent<ControllerComponent, ControlsEntity>(entities);
    final controllableEntities = this.getEntitiesByComponents<
        ControllableComponent, MovableComponent, SnakeEntity>(entities);

    controllerEntities.forEach((controllerEntity) {
      controllableEntities.forEach((controllableEntity) {
        final currentDirection = controllerEntity.getDirectionToApply();
        controllableEntity.speed =
            this._updateSpeedFromDirection(currentDirection);
      });
    });
  }

  Speed _updateSpeedFromDirection(Direction direction) {
    switch (direction) {
      case Direction.right:
        return Speed(dx: 1, dy: 0);
      case Direction.left:
        return Speed(dx: -1, dy: 0);
      case Direction.up:
        return Speed(dx: 0, dy: -1);
      case Direction.down:
        return Speed(dx: 0, dy: 1);
      default:
        return Speed(dx: 0, dy: 0);
    }
  }
}

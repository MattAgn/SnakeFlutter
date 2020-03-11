import 'package:snake_game/ecs/entities/snake.dart';
import 'package:snake_game/ecs/systems/system.dart';
import 'package:snake_game/ecs/components/movable.dart';
import 'package:snake_game/ecs/components/positions.dart';

class MoveSystem extends System {
  @override
  handleEntities(entities) {
    final movableEntities = this.getEntitiesByComponents<MovableComponent,
        PositionsComponent, SnakeEntity>(entities);

    movableEntities.forEach((entity) {
      final previousEntityHead = entity.coordinatesList.first;
      final entitySpeed = entity.speed;

      final newEntityHead = Coordinates(
          x: previousEntityHead.x + entitySpeed.dx,
          y: previousEntityHead.y + entitySpeed.dy);

      entity.coordinatesList.insert(0, newEntityHead);
      entity.coordinatesList.removeLast();
      print("New x position: " + entity.coordinatesList.first.x.toString());
      print("New y position: " + entity.coordinatesList.first.y.toString());
    });
  }
}

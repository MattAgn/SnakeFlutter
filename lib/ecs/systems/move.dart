import 'package:snake_game/ecs/entities/snake.dart';
import 'package:snake_game/ecs/systems/system.dart';
import 'package:snake_game/ecs/components/movable.dart';
import 'package:snake_game/ecs/components/position.dart';

class MoveSystem extends System {
  @override
  handleEntities(entities) {
    print("move system");
    final movableEntities =
        this.getEntitiesByComponents<Movable, Positions, Snake>(entities);
    print(movableEntities);
    movableEntities.forEach((entity) {
      final previousEntityHead = entity.positions.coordinatesList.first;
      final entitySpeed = entity.movable.speed;
      final newEntityHead = Coordinates(
          x: previousEntityHead.x + entitySpeed.dx,
          y: previousEntityHead.y + entitySpeed.dy);

      entity.positions.coordinatesList.insert(0, newEntityHead);
      entity.positions.coordinatesList.removeLast();
      print(entity.positions.coordinatesList.first.x);
    });
  }
}

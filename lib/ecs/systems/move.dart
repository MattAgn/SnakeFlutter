import 'package:snake_game/ecs/systems/system.dart';
import 'package:snake_game/ecs/components/movable.dart';

class MoveSystem extends System {
  @override
  handleEntities(entities) {
    print("move system");
    final movableEntities = this.getEntitiesByComponent<Movable>(entities);
    movableEntities.forEach((entity) {
      print(entity);
    });
  }
}

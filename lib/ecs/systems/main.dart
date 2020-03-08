import 'package:snake_game/ecs/components/eater.dart';
import 'package:snake_game/ecs/components/movable.dart';
import 'package:snake_game/ecs/components/position.dart';
import 'package:snake_game/ecs/entities/apple.dart';
import 'package:snake_game/ecs/entities/entity.dart';
import 'package:snake_game/ecs/entities/snake.dart';
import 'package:snake_game/ecs/systems/system.dart';

class GameSystem extends System {
  List<Entity> entities;
  static final Position initialSnakePosition =
      Position(coordinates: Coordinates(x: 0, y: 0));
  static final Position initialApplePosition =
      Position(coordinates: Coordinates(x: 1, y: 0));

  init() {
    final snake = Snake(
        movable: Movable(speed: Speed(dx: 0, dy: 0)),
        positions: [GameSystem.initialSnakePosition]);

    final apple = Apple(position: GameSystem.initialApplePosition);
    this.entities = [snake, apple];
    print("init game");
    final eaters = this.getEntitiesByComponent<Eater>(this.entities);
    print("eat");
    print(eaters);
  }
}

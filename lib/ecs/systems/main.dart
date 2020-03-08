import 'package:snake_game/ecs/components/movable.dart';
import 'package:snake_game/ecs/components/position.dart';
import 'package:snake_game/ecs/entities/apple.dart';
import 'package:snake_game/ecs/entities/entity.dart';
import 'package:snake_game/ecs/entities/snake.dart';
import 'package:snake_game/ecs/systems/move.dart';
import 'package:snake_game/ecs/systems/system.dart';

class GameSystem extends System {
  List<Entity> entities;
  static final Position initialSnakePosition =
      Position(coordinates: Coordinates(x: 0, y: 0));
  static final Position initialApplePosition =
      Position(coordinates: Coordinates(x: 1, y: 0));
  MoveSystem moveSystem;

  GameSystem() {
    this.moveSystem = new MoveSystem();
  }

  init() {
    print("init game");
    final snake = Snake(
        movable: Movable(speed: Speed(dx: 0, dy: 0)),
        positions: [GameSystem.initialSnakePosition]);
    final apple = Apple(position: GameSystem.initialApplePosition);
    this.entities = [snake, apple];
    this.moveSystem.handleEntities(this.entities);
  }
}

import 'dart:async';

import 'package:snake_game/ecs/components/movable.dart';
import 'package:snake_game/ecs/components/positions.dart';
import 'package:snake_game/ecs/entities/apple.dart';
import 'package:snake_game/ecs/entities/entity.dart';
import 'package:snake_game/ecs/entities/snake.dart';
import 'package:snake_game/ecs/systems/move.dart';
import 'package:snake_game/ecs/systems/system.dart';

class GameSystem extends System {
  static final initialSnakePosition = Coordinates(x: 1, y: 0);
  static final initialApplePosition = Coordinates(x: 1, y: 0);
  List<Entity> entities;
  MoveSystem moveSystem;
  Timer timer;

  GameSystem() {
    this.moveSystem = MoveSystem();
  }

  init() {
    print("init game");
    final snake = SnakeEntity();
    final apple = AppleEntity();
    apple.coordinatesList = [initialApplePosition];
    snake.coordinatesList = [initialSnakePosition];
    snake.speed = Speed(dx: 2, dy: 1);
    this.entities = [snake, apple];

    timer = Timer.periodic(Duration(seconds: 1), (_) {
      moveSystem.handleEntities(entities);
    });
  }

  stop() {
    timer?.cancel();
  }
}

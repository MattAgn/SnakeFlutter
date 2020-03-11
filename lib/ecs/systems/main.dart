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

  initEntities() {
    print("init entities");
    final snake = SnakeEntity();
    final apple = AppleEntity();
    apple.coordinatesList = [initialApplePosition];
    snake.coordinatesList = [initialSnakePosition];
    snake.speed = Speed(dx: 2, dy: 1);
    this.entities = [snake, apple];
  }

  play() {
    print("play");
    if (this.entities == null) {
      this.initEntities();
    }
    this.timer = Timer.periodic(Duration(milliseconds: 50), (_) {
      moveSystem.handleEntities(entities);
      notifyListeners();
    });
  }

  stop() {
    print("stop");
    this.timer?.cancel();
    this.initEntities();
    notifyListeners();
  }

  pause() {
    print("pause");
    this.timer?.cancel();
    notifyListeners();
  }

  get snakeCoordinates {
    final snake = this.entities?.firstWhere((entity) => entity is SnakeEntity)
        as SnakeEntity;
    return snake?.coordinatesList?.first;
  }

  get appleCoordinates {
    final apple = this.entities?.firstWhere((entity) => entity is AppleEntity)
        as AppleEntity;
    return apple?.coordinatesList?.first;
  }
}

import 'dart:async';

import 'package:snake_game/ecs/components/movable.dart';
import 'package:snake_game/ecs/components/positions.dart';
import 'package:snake_game/ecs/entities/apple.dart';
import 'package:snake_game/ecs/entities/entity.dart';
import 'package:snake_game/ecs/entities/snake.dart';
import 'package:snake_game/ecs/systems/move.dart';
import 'package:snake_game/ecs/systems/system.dart';

enum GameStatus { play, pause, stop, gameOver }
const BOARD_SIZE = 40;

class GameSystem extends System {
  static final initialSnakePosition = Coordinates(x: 1, y: 10);
  static final initialApplePosition = Coordinates(x: 10, y: 1);
  List<Entity> entities;
  MoveSystem moveSystem;
  Timer timer;
  GameStatus gameStatus;

  GameSystem() {
    this.moveSystem = MoveSystem();
    this.gameStatus = GameStatus.stop;
  }

  initEntities() {
    print("init entities");
    final snake = SnakeEntity();
    final apple = AppleEntity();
    apple.coordinatesList = [initialApplePosition];
    snake.coordinatesList = [initialSnakePosition];
    snake.speed = Speed(dx: 1, dy: 0);
    this.entities = [snake, apple];
  }

  play() {
    print("play");
    this.gameStatus = GameStatus.play;
    if (this.entities == null) {
      this.initEntities();
    }
    this.timer = Timer.periodic(Duration(milliseconds: 70), (_) {
      moveSystem.handleEntities(entities);
      notifyListeners();
    });
  }

  stop() {
    print("stop");
    this.gameStatus = GameStatus.stop;
    this.timer?.cancel();
    this.initEntities();
    notifyListeners();
  }

  pause() {
    this.gameStatus = GameStatus.pause;
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

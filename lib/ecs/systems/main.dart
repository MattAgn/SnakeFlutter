import 'dart:async';

import 'package:snake_game/ecs/components/controller.dart';
import 'package:snake_game/ecs/components/movable.dart';
import 'package:snake_game/ecs/components/positions.dart';
import 'package:snake_game/ecs/entities/apple.dart';
import 'package:snake_game/ecs/entities/controls.dart';
import 'package:snake_game/ecs/entities/entity.dart';
import 'package:snake_game/ecs/entities/snake.dart';
import 'package:snake_game/ecs/systems/control.dart';
import 'package:snake_game/ecs/systems/move.dart';
import 'package:snake_game/ecs/systems/system.dart';

enum GameStatus { play, pause, stop, gameOver }
const BOARD_SIZE = 40;

class GameSystem extends System {
  static final initialSnakePosition = Coordinates(x: 1, y: 10);
  static final initialApplePosition = Coordinates(x: 10, y: 1);
  List<Entity> entities;
  MoveSystem moveSystem;
  ControlSystem controlSystem;
  Timer timer;
  GameStatus gameStatus;

  GameSystem() {
    this.moveSystem = MoveSystem();
    this.controlSystem = ControlSystem();
    this.gameStatus = GameStatus.stop;
  }

  initEntities() {
    print("init entities");
    final snake = SnakeEntity();
    final apple = AppleEntity();
    final controls = ControlsEntity();
    apple.leadPosition = [initialApplePosition];
    snake.leadPosition = [initialSnakePosition];
    snake.speed = Speed(dx: 1, dy: 0);
    this.entities = [snake, apple, controls];
  }

  play() {
    print("play");
    this.gameStatus = GameStatus.play;
    if (this.entities == null) {
      this.initEntities();
    }
    this.timer = Timer.periodic(Duration(milliseconds: 70), (_) {
      controlSystem.handleEntities(entities);
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
    return snake?.leadPosition;
  }

  get appleCoordinates {
    final apple = this.entities?.firstWhere((entity) => entity is AppleEntity)
        as AppleEntity;
    return apple?.leadPosition;
  }

  set direction(Direction direction) {
    final controls = this
        .entities
        ?.firstWhere((entity) => entity is ControlsEntity) as ControlsEntity;
    if ((direction == Direction.down && controls.direction != Direction.up) ||
        (direction == Direction.up && controls.direction != Direction.down) ||
        (direction == Direction.rigth &&
            controls.direction != Direction.left) ||
        (direction == Direction.left &&
            controls.direction != Direction.rigth)) {
      controls.direction = direction;
    }
    controlSystem.handleEntities(entities);
    notifyListeners();
  }
}

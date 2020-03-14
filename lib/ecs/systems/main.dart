import 'dart:async';

import 'package:snake_game/ecs/components/controller.dart';
import 'package:snake_game/ecs/components/movable.dart';
import 'package:snake_game/ecs/components/position.dart';
import 'package:snake_game/ecs/entities/apple.dart';
import 'package:snake_game/ecs/entities/controls.dart';
import 'package:snake_game/ecs/entities/entity.dart';
import 'package:snake_game/ecs/entities/portal.dart';
import 'package:snake_game/ecs/entities/snake.dart';
import 'package:snake_game/ecs/entities/wall.dart';
import 'package:snake_game/ecs/systems/control.dart';
import 'package:snake_game/ecs/systems/death.dart';
import 'package:snake_game/ecs/systems/eat.dart';
import 'package:snake_game/ecs/systems/move.dart';
import 'package:snake_game/ecs/systems/system.dart';

enum GameStatus { play, pause, stop, gameOver }
const BOARD_SIZE = 30;

class GameSystem extends System {
  static final initialSnakePosition = Coordinates(x: 2, y: 2);
  static final initialSnakeSpeed = Speed(dx: 1, dy: 0);
  static final initialApplePosition = Coordinates(x: 10, y: 2);
  List<Entity> entities;
  MoveSystem moveSystem;
  ControlSystem controlSystem;
  EatSystem eatSystem;
  DeathSystem deathSystem;
  Timer timer;
  GameStatus gameStatus;

  GameSystem() {
    this.moveSystem = MoveSystem();
    this.controlSystem = ControlSystem();
    this.eatSystem = EatSystem();
    this.deathSystem = DeathSystem();
    this.gameStatus = GameStatus.stop;
  }

  initEntities() {
    print("init entities");
    final snake = SnakeEntity(initialSnakePosition, initialSnakeSpeed);
    final apple = AppleEntity(initialApplePosition);
    final controls = ControlsEntity();
    final walls = _initWalls();
    final portals = _initPortals();
    this.entities = [snake, apple, controls, ...portals, ...walls];
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
      eatSystem.handleEntities(entities);
      deathSystem.handleEntities(entities);
      deathSystem.handleDeadEntities(entities, setGameOver);
      notifyListeners();
    });
  }

  replay() {
    this.initEntities();
    play();
  }

  setGameOver() {
    print('Game Over');
    this.gameStatus = GameStatus.gameOver;
    this.timer?.cancel();
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

  SnakeEntity get snake {
    final snake = this.entities?.firstWhere((entity) => entity is SnakeEntity)
        as SnakeEntity;
    return snake;
  }

  AppleEntity get apple {
    final apple = this.entities?.firstWhere((entity) => entity is AppleEntity)
        as AppleEntity;
    return apple;
  }

  List<WallEntity> get walls {
    final walls = this
        .entities
        ?.where((entity) => entity is WallEntity)
        ?.map((entity) => entity as WallEntity)
        ?.toList();
    return walls;
  }

  List<PortalEntity> get portals {
    final portals = this
        .entities
        ?.where((entity) => entity is PortalEntity)
        ?.map((entity) => entity as PortalEntity)
        ?.toList();
    return portals;
  }

  set direction(Direction direction) {
    final controls = this
        .entities
        ?.firstWhere((entity) => entity is ControlsEntity) as ControlsEntity;
    if (controls != null &&
            (direction == Direction.down &&
                controls.direction != Direction.up) ||
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

  List<WallEntity> _initWalls() {
    return [
      WallEntity(Coordinates(x: 10, y: 10)),
      WallEntity(Coordinates(x: 11, y: 10)),
      WallEntity(Coordinates(x: 12, y: 10)),
      WallEntity(Coordinates(x: 13, y: 10)),
      WallEntity(Coordinates(x: 14, y: 10)),
      WallEntity(Coordinates(x: 15, y: 10)),
      WallEntity(Coordinates(x: 16, y: 10)),
      WallEntity(Coordinates(x: 17, y: 10)),
    ];
  }

  _initPortals() {
    final List<Entity> portals = [];
    for (var i = 0; i <= BOARD_SIZE; i++) {
      portals.add(PortalEntity(
          Coordinates(x: BOARD_SIZE, y: i), Coordinates(x: 1, y: i)));
      portals.add(PortalEntity(
          Coordinates(x: i, y: BOARD_SIZE), Coordinates(x: i, y: 1)));
      portals.add(PortalEntity(
          Coordinates(x: 0, y: i), Coordinates(x: BOARD_SIZE - 1, y: i)));
      portals.add(PortalEntity(
          Coordinates(x: i, y: 0), Coordinates(x: i, y: BOARD_SIZE - 1)));
    }
    return portals;
  }
}

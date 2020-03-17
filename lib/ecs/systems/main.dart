import 'dart:async';

import 'package:snake_game/ecs/components/controller.dart';
import 'package:snake_game/ecs/entities/apple.dart';
import 'package:snake_game/ecs/entities/controls.dart';
import 'package:snake_game/ecs/entities/entity.dart';
import 'package:snake_game/ecs/entities/portal.dart';
import 'package:snake_game/ecs/entities/snake.dart';
import 'package:snake_game/ecs/entities/wall.dart';
import 'package:snake_game/ecs/systems/control.dart';
import 'package:snake_game/ecs/systems/death.dart';
import 'package:snake_game/ecs/systems/eat.dart';
import 'package:snake_game/ecs/systems/init.dart';
import 'package:snake_game/ecs/systems/move.dart';
import 'package:snake_game/ecs/systems/options.dart';
import 'package:snake_game/ecs/systems/system.dart';

enum GameStatus { play, pause, stop, gameOver }

class GameSystem extends System {
  List<Entity> entities;
  MoveSystem moveSystem;
  ControlSystem controlSystem;
  EatSystem eatSystem;
  DeathSystem deathSystem;
  InitSystem initSystem;
  OptionsSystem optionsSystem;
  Timer timer;
  GameStatus gameStatus;

  GameSystem() {
    this.moveSystem = MoveSystem();
    this.controlSystem = ControlSystem();
    this.eatSystem = EatSystem();
    this.deathSystem = DeathSystem();
    this.initSystem = InitSystem();
    this.optionsSystem = OptionsSystem(notifyListener: notifyListeners);
    this.gameStatus = GameStatus.stop;
  }

  initEntities() {
    return this.initSystem.initEntities(
          nbRandomPortals: this.optionsSystem.nbRandomPortals,
          nbRandomWalls: this.optionsSystem.nbRandomWalls,
          surroundingBoardEntityType: optionsSystem.surroundingBoardEntityType,
        );
  }

  play() {
    print("play");
    this.gameStatus = GameStatus.play;
    if (this.entities == null) {
      this.entities = this.initEntities();
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
    this.entities = this.initEntities();
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
    this.entities = this.initEntities();
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
        (direction == Direction.right &&
            controls.direction != Direction.left) ||
        (direction == Direction.left &&
            controls.direction != Direction.right)) {
      controls.direction = direction;
    }
    controlSystem.handleEntities(entities);
    notifyListeners();
  }

  set nbRandomWalls(int nbRandomWalls) {
    this.optionsSystem.nbRandomWalls = nbRandomWalls;
    notifyListeners();
  }

  set nbRandomPortals(int nbRandomPortals) {
    this.optionsSystem.nbRandomPortals = nbRandomPortals;
    notifyListeners();
  }
}

import 'dart:async';

import 'package:snake_game/ecs/components/controller.dart';
import 'package:snake_game/ecs/components/renderable.dart';
import 'package:snake_game/ecs/data/levels.dart';
import 'package:snake_game/ecs/entities/controls.dart';
import 'package:snake_game/ecs/entities/entity.dart';
import 'package:snake_game/ecs/entities/snake.dart';
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
  int levelNumber;

  GameSystem() {
    this.moveSystem = MoveSystem();
    this.controlSystem = ControlSystem();
    this.eatSystem = EatSystem();
    this.deathSystem = DeathSystem();
    this.initSystem = InitSystem();
    this.optionsSystem = OptionsSystem(notifyGameListeners: notifyListeners);
    this.gameStatus = GameStatus.stop;
  }

  initEntities() {
    if (levelNumber != null) {
      LevelOptions levelOptions = levelsOptions[levelNumber];
      this.entities = this.initSystem.initEntities(
            nbRandomPortals: levelOptions.nbRandomPortals,
            nbRandomWalls: levelOptions.nbRandomWalls,
            surroundingBoardEntityType: levelOptions.surroundingBoardEntityType,
            predefinedPortalsCoordinates: levelOptions.portalsCoordinates,
            predefinedWallsCoordinates: levelOptions.wallsCoordinates,
          );
    } else {
      this.entities = this.initSystem.initEntities(
            nbRandomPortals: this.optionsSystem.nbRandomPortals,
            nbRandomWalls: this.optionsSystem.nbRandomWalls,
            surroundingBoardEntityType:
                optionsSystem.surroundingBoardEntityType,
          );
    }
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

  reset() {
    print("reset");
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

  playOrPause() {
    gameStatus == GameStatus.play ? pause() : play();
  }

  int get score {
    final SnakeEntity snake = this
        .entities
        ?.firstWhere((entity) => entity is SnakeEntity) as SnakeEntity;
    return snake?.body?.length ?? 0;
  }

  List<Entity> get renderableEntities {
    final renderableEntities = this
        .entities
        ?.where((entity) => entity is RenderableComponent)
        ?.toList();
    return renderableEntities ?? [];
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
}

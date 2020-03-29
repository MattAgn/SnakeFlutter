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

enum GameStatus { play, pause, reset, gameOver }

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
  int _levelNumber;

  GameSystem() {
    this.moveSystem = MoveSystem();
    this.controlSystem = ControlSystem();
    this.eatSystem = EatSystem();
    this.deathSystem = DeathSystem();
    this.initSystem = InitSystem();
    this.optionsSystem = OptionsSystem(notifyGameListeners: notifyListeners);
    this.gameStatus = GameStatus.reset;
  }

  initEntities() {
    this.entities = this.initSystem.initEntities(this.optionsSystem);
  }

  play() {
    print("play");
    this.gameStatus = GameStatus.play;
    if (this.entities == null) {
      this.initEntities();
    }
    this.timer = Timer.periodic(
        Duration(milliseconds: (1 / optionsSystem.gameSpeed).round()), (_) {
      controlSystem.handleEntities(entities);
      moveSystem.handleEntities(entities);
      eatSystem.handleEntities(entities, optionsSystem);
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
    this.gameStatus = GameStatus.reset;
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

  List<PositionedOnBoard> renderEntities(double boardSquareSize) {
    final renderedEntities = this
        .entities
        ?.where((entity) => entity is RenderableComponent)
        ?.map((entity) {
          final renderableEntity = entity as RenderableComponent;
          return renderableEntity.paint(boardSquareSize);
        })
        ?.expand((renderedElement) => renderedElement)
        ?.toList();
    return renderedEntities ?? [];
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

  set levelNumber(int levelNumber) {
    LevelOptions levelOptions = levelsOptions[levelNumber];
    optionsSystem
      ..boardSize = levelOptions.boardSize
      ..gameSpeed = levelOptions.gameSpeed
      ..wallsCoordinates = levelOptions.wallsCoordinates
      ..minWinningScore = levelOptions.minWinningScore
      ..surroundingBoardEntityType = levelOptions.surroundingBoardEntityType
      ..nbRandomPortals = levelOptions.nbRandomPortals
      ..nbRandomWalls = levelOptions.nbRandomWalls;
    _levelNumber = levelNumber;
  }

  get levelNumber => _levelNumber;
}

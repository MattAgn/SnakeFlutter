import 'dart:math';

import 'package:flutter/material.dart';
import 'package:snake_game/ecs/components/body.dart';
import 'package:snake_game/ecs/components/movable.dart';
import 'package:snake_game/ecs/components/position.dart';
import 'package:snake_game/ecs/entities/apple.dart';
import 'package:snake_game/ecs/entities/board.dart';
import 'package:snake_game/ecs/entities/controls.dart';
import 'package:snake_game/ecs/entities/entity.dart';
import 'package:snake_game/ecs/entities/portal.dart';
import 'package:snake_game/ecs/entities/snake.dart';
import 'package:snake_game/ecs/entities/wall.dart';
import 'package:snake_game/ecs/systems/options.dart';
import 'package:snake_game/ecs/systems/system.dart';

class InitSystem extends System {
  static final initialSnakePosition = Coordinates(x: 2, y: 2);
  static final initialSnakeSpeed = Speed(dx: 1, dy: 0);
  static final initialApplePosition = Coordinates(x: 4, y: 2);
  List<Entity> entities = [];

  initEntities(OptionsSystem optionsSystem) {
    print("init entities");
    final controls = ControlsEntity();
    final board = BoardEntity(optionsSystem.boardSize);
    this.entities = [];
    // order is important below because random coordinates
    // are generated based on the previous coordinates
    // while snake, apple and boardSurroundings have fixed coordinates
    _initSnake();
    _initPredefinedWalls(
        optionsSystem.wallsCoordinates, optionsSystem.boardSize);
    _initApple();
    _initBoardSurroundings(
        optionsSystem.surroundingBoardEntityType, optionsSystem.boardSize);
    _initRandomPortals(optionsSystem.nbRandomPortals, optionsSystem.boardSize);
    _initRandomWalls(optionsSystem.nbRandomWalls, optionsSystem.boardSize);
    return [controls, board, ...this.entities];
  }

  void _initApple() {
    this.entities.add(AppleEntity(initialApplePosition));
  }

  void _initSnake() {
    this.entities.add(SnakeEntity(initialSnakePosition, initialSnakeSpeed));
  }

  void _initBoardSurroundings(Type surroundingBoardEntityType, int boardSize) {
    if (surroundingBoardEntityType == PortalEntity) {
      _initBoardSurroundingPortals(boardSize);
    } else if (surroundingBoardEntityType == WallEntity) {
      _initBoardSurroundingWalls(boardSize);
    } else {
      throw ErrorDescription("INVALID SURROUNDING ENTITY");
    }
  }

  void _initBoardSurroundingPortals(int boardSize) {
    final List<PortalEntity> portals = [];
    for (var i = 0; i < boardSize; i++) {
      portals.add(PortalEntity(
          Coordinates(x: boardSize, y: i), Coordinates(x: -1, y: i)));
      portals.add(PortalEntity(
          Coordinates(x: i, y: boardSize), Coordinates(x: i, y: -1)));
      portals.add(PortalEntity(
          Coordinates(x: -1, y: i), Coordinates(x: boardSize, y: i)));
      portals.add(PortalEntity(
          Coordinates(x: i, y: -1), Coordinates(x: i, y: boardSize)));
    }
    this.entities.addAll(portals);
  }

  void _initBoardSurroundingWalls(int boardSize) {
    final List<WallEntity> walls = [];
    for (var i = 0; i < boardSize; i++) {
      walls.add(WallEntity(Coordinates(x: boardSize - 1, y: i), boardSize));
      walls.add(WallEntity(Coordinates(x: i, y: boardSize - 1), boardSize));
      walls.add(WallEntity(Coordinates(x: 0, y: i), boardSize));
      walls.add(WallEntity(Coordinates(x: i, y: 0), boardSize));
    }
    this.entities.addAll(walls);
  }

  void _initRandomWalls(int nbWalls, int boardSize) {
    for (var i = 0; i < nbWalls; i++) {
      final randomCoordinates =
          InitSystem.getRandomCoordinates(boardSize, this.entities);
      this.entities.add(WallEntity(randomCoordinates, boardSize));
    }
  }

  void _initRandomPortals(int nbPortals, int boardSize) {
    for (var i = 0; i < nbPortals; i++) {
      final randomLeadPosition =
          InitSystem.getRandomCoordinates(boardSize, this.entities);
      final randomExitPosition = InitSystem.getRandomCoordinates(
          boardSize, this.entities, [randomLeadPosition]);
      this.entities.add(PortalEntity(randomLeadPosition, randomExitPosition));
    }
  }

  void _initPredefinedWalls(
      List<Coordinates> predefinedWallsCoordinates, int boardSize) {
    for (final wallCoordinates in predefinedWallsCoordinates) {
      this.entities.add(WallEntity(wallCoordinates, boardSize));
    }
  }

  void _initPredefinedPortals(List<Coordinates> predefinedPortalsCoordinates) {
    // TODO: to implement
  }

  /// TODO: improve this function so that it does not use recursion to find
  /// available random coordinates
  static getRandomCoordinates(int boardSize, List<Entity> entities,
      [List<Coordinates> unreferencedUnavailablePositions]) {
    final List<Coordinates> unavailableBodyPositions = entities
        .where((entity) => entity is BodyComponent)
        .map((entity) => (entity as BodyComponent).body)
        .expand((body) => body)
        .toList();

    final List<Coordinates> unavailablePositions = entities
        .where((entity) => entity is LeadPositionComponent)
        .map((entity) => (entity as LeadPositionComponent).leadPosition)
        .toList()
          ..addAll(unavailableBodyPositions)
          ..addAll(unreferencedUnavailablePositions ?? []);

    return _getAvailableCoordinates(unavailablePositions.toList(), boardSize);
  }

  static Coordinates _getAvailableCoordinates(
      List<Coordinates> unavailablePositions, int boardSize) {
    final randomCoordinates = Coordinates(
        x: Random().nextInt(boardSize - 2) + 1,
        y: Random().nextInt(boardSize - 2) + 1);
    if (unavailablePositions.contains(randomCoordinates)) {
      return _getAvailableCoordinates(unavailablePositions, boardSize);
    }
    return randomCoordinates;
  }
}

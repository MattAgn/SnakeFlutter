import 'dart:math';

import 'package:flutter/material.dart';
import 'package:snake_game/ecs/components/body.dart';
import 'package:snake_game/ecs/components/movable.dart';
import 'package:snake_game/ecs/components/position.dart';
import 'package:snake_game/ecs/entities/apple.dart';
import 'package:snake_game/ecs/entities/controls.dart';
import 'package:snake_game/ecs/entities/entity.dart';
import 'package:snake_game/ecs/entities/portal.dart';
import 'package:snake_game/ecs/entities/snake.dart';
import 'package:snake_game/ecs/entities/wall.dart';
import 'package:snake_game/ecs/systems/system.dart';

const BOARD_SIZE = 30;

class InitSystem extends System {
  static final initialSnakePosition = Coordinates(x: 2, y: 2);
  static final initialSnakeSpeed = Speed(dx: 1, dy: 0);
  static final initialApplePosition = Coordinates(x: 10, y: 2);
  List<Entity> entities = [];

  initEntities({
    int nbRandomWalls = 0,
    int nbRandomPortals = 0,
    Type surroundingBoardEntityType,
    List<Coordinates> predefinedWallsCoordinates = const [],
    List<Coordinates> predefinedPortalsCoordinates = const [],
  }) {
    print("init entities");
    final controls = ControlsEntity();
    this.entities = [];
    // order is important below because random coordinates
    // are generated based on the previous coordinates
    // while snake, apple and boardSurroundings have fixed coordinates
    _initSnake();
    _initPredefinedWalls(predefinedWallsCoordinates);
    _initPredefinedPortals(predefinedPortalsCoordinates);
    _initApple();
    _initBoardSurroundings(surroundingBoardEntityType);
    _initRandomPortals(nbRandomPortals);
    _initRandomWalls(nbRandomWalls);
    return [controls, ...this.entities];
  }

  void _initApple() {
    this.entities.add(AppleEntity(initialApplePosition));
  }

  void _initSnake() {
    this.entities.add(SnakeEntity(initialSnakePosition, initialSnakeSpeed));
  }

  void _initBoardSurroundings(Type surroundingBoardEntityType) {
    if (surroundingBoardEntityType == PortalEntity) {
      _initBoardSurroundingPortals();
    } else if (surroundingBoardEntityType == WallEntity) {
      _initBoardSurroundingWalls();
    } else {
      throw ErrorDescription("INVALID SURROUNDING ENTITY");
    }
  }

  void _initBoardSurroundingPortals() {
    final List<PortalEntity> portals = [];
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
    this.entities.addAll(portals);
  }

  void _initBoardSurroundingWalls() {
    final List<WallEntity> walls = [];
    for (var i = 0; i <= BOARD_SIZE; i++) {
      walls.add(WallEntity(Coordinates(x: BOARD_SIZE, y: i)));
      walls.add(WallEntity(Coordinates(x: i, y: BOARD_SIZE)));
      walls.add(WallEntity(Coordinates(x: 0, y: i)));
      walls.add(WallEntity(Coordinates(x: i, y: 0)));
    }
    this.entities.addAll(walls);
  }

  void _initRandomWalls(int nbWalls) {
    for (var i = 0; i < nbWalls; i++) {
      final randomCoordinates = InitSystem.getRandomCoordinates(this.entities);
      this.entities.add(WallEntity(randomCoordinates));
    }
  }

  void _initRandomPortals(int nbPortals) {
    for (var i = 0; i < nbPortals; i++) {
      final randomLeadPosition = InitSystem.getRandomCoordinates(this.entities);
      final randomExitPosition =
          InitSystem.getRandomCoordinates(this.entities, [randomLeadPosition]);
      this.entities.add(PortalEntity(randomLeadPosition, randomExitPosition));
    }
  }

  void _initPredefinedWalls(List<Coordinates> predefinedWallsCoordinates) {
    for (final wallCoordinates in predefinedWallsCoordinates) {
      this.entities.add(WallEntity(wallCoordinates));
    }
  }

  void _initPredefinedPortals(List<Coordinates> predefinedPortalsCoordinates) {
    // TODO: to implement
  }

  /// TODO: improve this function so that it does not use recursion to find
  /// available random coordinates
  static getRandomCoordinates(List<Entity> entities,
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

    return _getAvailableCoordinates(unavailablePositions.toList());
  }

  static Coordinates _getAvailableCoordinates(
      List<Coordinates> unavailablePositions) {
    final randomCoordinates = Coordinates(
        x: Random().nextInt(BOARD_SIZE - 2) + 1,
        y: Random().nextInt(BOARD_SIZE - 2) + 1);
    if (unavailablePositions.contains(randomCoordinates)) {
      return _getAvailableCoordinates(unavailablePositions);
    }
    return randomCoordinates;
  }
}

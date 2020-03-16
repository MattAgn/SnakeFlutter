import 'dart:math';

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
  List<Entity> entities;

  initEntities() {
    print("init entities");
    final controls = ControlsEntity();
    return [
      controls,
      _initSnake(),
      _initApple(),
      ..._initWalls(),
      ..._initPortals()
    ];
  }

  AppleEntity _initApple() {
    return AppleEntity(initialApplePosition);
  }

  SnakeEntity _initSnake() {
    return SnakeEntity(initialSnakePosition, initialSnakeSpeed);
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

  List<PortalEntity> _initPortals() {
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
    return portals;
  }

  static getRandomCoordinates(List<Entity> entities) {
    final List<Coordinates> unavailablePositions = entities
        .where((entity) => entity is LeadPositionComponent)
        .map((entity) => (entity as LeadPositionComponent).leadPosition)
        .toList();
    return _getAvailableCoordinates(unavailablePositions);
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

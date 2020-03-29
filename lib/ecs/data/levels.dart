import 'package:flutter/material.dart';
import 'package:snake_game/ecs/components/position.dart';
import 'package:snake_game/ecs/entities/portal.dart';

class LevelOptions {
  final Type surroundingBoardEntityType;
  final int nbRandomWalls;
  final int nbRandomPortals;
  final List<Coordinates> wallsCoordinates;
  final List<Coordinates> portalsCoordinates;
  final int minWinningScore;
  final int boardSize;

  /// inverse of the time in milliseconds between 2 iterations of the game loop
  final double gameSpeed;

  LevelOptions(
      {this.surroundingBoardEntityType = PortalEntity,
      @required this.minWinningScore,
      this.nbRandomPortals = 0,
      this.boardSize = 20,
      this.gameSpeed = 1 / 100,
      this.nbRandomWalls = 0,
      this.portalsCoordinates = const [],
      this.wallsCoordinates = const []});
}

final levelsOptions = {
  0: LevelOptions(minWinningScore: 30, boardSize: 10),
  1: LevelOptions(minWinningScore: 30, wallsCoordinates: [
    Coordinates(x: (25 / 2).floor() - 7, y: (25 / 2).floor()),
    Coordinates(x: (25 / 2).floor() - 6, y: (25 / 2).floor()),
    Coordinates(x: (25 / 2).floor() - 5, y: (25 / 2).floor()),
    Coordinates(x: (25 / 2).floor() - 4, y: (25 / 2).floor()),
    Coordinates(x: (25 / 2).floor() - 3, y: (25 / 2).floor()),
    Coordinates(x: (25 / 2).floor() - 2, y: (25 / 2).floor()),
    Coordinates(x: (25 / 2).floor() - 1, y: (25 / 2).floor()),
    Coordinates(x: (25 / 2).floor(), y: (25 / 2).floor()),
    Coordinates(x: (25 / 2).floor() + 7, y: (25 / 2).floor()),
    Coordinates(x: (25 / 2).floor() + 6, y: (25 / 2).floor()),
    Coordinates(x: (25 / 2).floor() + 5, y: (25 / 2).floor()),
    Coordinates(x: (25 / 2).floor() + 4, y: (25 / 2).floor()),
    Coordinates(x: (25 / 2).floor() + 3, y: (25 / 2).floor()),
    Coordinates(x: (25 / 2).floor() + 2, y: (25 / 2).floor()),
    Coordinates(x: (25 / 2).floor() + 1, y: (25 / 2).floor()),
  ]),
  2: LevelOptions(minWinningScore: 30, wallsCoordinates: [
    Coordinates(y: (25 / 2).floor() - 9, x: (25 / 3).floor()),
    Coordinates(y: (25 / 2).floor() - 8, x: (25 / 3).floor()),
    Coordinates(y: (25 / 2).floor() - 6, x: (25 / 3).floor()),
    Coordinates(y: (25 / 2).floor() - 7, x: (25 / 3).floor()),
    Coordinates(y: (25 / 2).floor() - 5, x: (25 / 3).floor()),
    Coordinates(y: (25 / 2).floor() - 4, x: (25 / 3).floor()),
    Coordinates(y: (25 / 2).floor() - 3, x: (25 / 3).floor()),
    Coordinates(y: (25 / 2).floor() - 2, x: (25 / 3).floor()),
    Coordinates(y: (25 / 2).floor() - 1, x: (25 / 3).floor()),
    Coordinates(y: (25 / 2).floor(), x: (25 / 3).floor()),
    Coordinates(y: (25 / 2).floor() + 9, x: (25 / 3).floor()),
    Coordinates(y: (25 / 2).floor() + 8, x: (25 / 3).floor()),
    Coordinates(y: (25 / 2).floor() + 7, x: (25 / 3).floor()),
    Coordinates(y: (25 / 2).floor() + 6, x: (25 / 3).floor()),
    Coordinates(y: (25 / 2).floor() + 5, x: (25 / 3).floor()),
    Coordinates(y: (25 / 2).floor() + 4, x: (25 / 3).floor()),
    Coordinates(y: (25 / 2).floor() + 3, x: (25 / 3).floor()),
    Coordinates(y: (25 / 2).floor() + 2, x: (25 / 3).floor()),
    Coordinates(y: (25 / 2).floor() + 1, x: (25 / 3).floor()),
    Coordinates(y: (25 / 2).floor() - 9, x: (25 / 3 * 2).floor()),
    Coordinates(y: (25 / 2).floor() - 8, x: (25 / 3 * 2).floor()),
    Coordinates(y: (25 / 2).floor() - 6, x: (25 / 3 * 2).floor()),
    Coordinates(y: (25 / 2).floor() - 7, x: (25 / 3 * 2).floor()),
    Coordinates(y: (25 / 2).floor() - 5, x: (25 / 3 * 2).floor()),
    Coordinates(y: (25 / 2).floor() - 4, x: (25 / 3 * 2).floor()),
    Coordinates(y: (25 / 2).floor() - 3, x: (25 / 3 * 2).floor()),
    Coordinates(y: (25 / 2).floor() - 2, x: (25 / 3 * 2).floor()),
    Coordinates(y: (25 / 2).floor() - 1, x: (25 / 3 * 2).floor()),
    Coordinates(y: (25 / 2).floor(), x: (25 / 3 * 2).floor()),
    Coordinates(y: (25 / 2).floor() + 9, x: (25 / 3 * 2).floor()),
    Coordinates(y: (25 / 2).floor() + 8, x: (25 / 3 * 2).floor()),
    Coordinates(y: (25 / 2).floor() + 7, x: (25 / 3 * 2).floor()),
    Coordinates(y: (25 / 2).floor() + 6, x: (25 / 3 * 2).floor()),
    Coordinates(y: (25 / 2).floor() + 5, x: (25 / 3 * 2).floor()),
    Coordinates(y: (25 / 2).floor() + 4, x: (25 / 3 * 2).floor()),
    Coordinates(y: (25 / 2).floor() + 3, x: (25 / 3 * 2).floor()),
    Coordinates(y: (25 / 2).floor() + 2, x: (25 / 3 * 2).floor()),
    Coordinates(y: (25 / 2).floor() + 1, x: (25 / 3 * 2).floor()),
  ]),
};

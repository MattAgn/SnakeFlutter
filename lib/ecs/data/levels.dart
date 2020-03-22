import 'package:flutter/material.dart';
import 'package:snake_game/ecs/components/position.dart';
import 'package:snake_game/ecs/entities/portal.dart';
import 'package:snake_game/ecs/systems/init.dart';

const List<Coordinates> emptyList = [];

class LevelOptions {
  final Type surroundingBoardEntityType;
  final int nbRandomWalls;
  final int nbRandomPortals;
  final List<Coordinates> wallsCoordinates;
  final List<Coordinates> portalsCoordinates;
  final int minWinningScore;

  LevelOptions(
      {this.surroundingBoardEntityType = PortalEntity,
      @required this.minWinningScore,
      this.nbRandomPortals = 0,
      this.nbRandomWalls = 0,
      this.portalsCoordinates = emptyList,
      this.wallsCoordinates = emptyList});
}

final levelsOptions = {
  0: LevelOptions(minWinningScore: 30),
  1: LevelOptions(minWinningScore: 30, wallsCoordinates: [
    Coordinates(x: (BOARD_SIZE / 2).floor() - 7, y: (BOARD_SIZE / 2).floor()),
    Coordinates(x: (BOARD_SIZE / 2).floor() - 6, y: (BOARD_SIZE / 2).floor()),
    Coordinates(x: (BOARD_SIZE / 2).floor() - 5, y: (BOARD_SIZE / 2).floor()),
    Coordinates(x: (BOARD_SIZE / 2).floor() - 4, y: (BOARD_SIZE / 2).floor()),
    Coordinates(x: (BOARD_SIZE / 2).floor() - 3, y: (BOARD_SIZE / 2).floor()),
    Coordinates(x: (BOARD_SIZE / 2).floor() - 2, y: (BOARD_SIZE / 2).floor()),
    Coordinates(x: (BOARD_SIZE / 2).floor() - 1, y: (BOARD_SIZE / 2).floor()),
    Coordinates(x: (BOARD_SIZE / 2).floor(), y: (BOARD_SIZE / 2).floor()),
    Coordinates(x: (BOARD_SIZE / 2).floor() + 7, y: (BOARD_SIZE / 2).floor()),
    Coordinates(x: (BOARD_SIZE / 2).floor() + 6, y: (BOARD_SIZE / 2).floor()),
    Coordinates(x: (BOARD_SIZE / 2).floor() + 5, y: (BOARD_SIZE / 2).floor()),
    Coordinates(x: (BOARD_SIZE / 2).floor() + 4, y: (BOARD_SIZE / 2).floor()),
    Coordinates(x: (BOARD_SIZE / 2).floor() + 3, y: (BOARD_SIZE / 2).floor()),
    Coordinates(x: (BOARD_SIZE / 2).floor() + 2, y: (BOARD_SIZE / 2).floor()),
    Coordinates(x: (BOARD_SIZE / 2).floor() + 1, y: (BOARD_SIZE / 2).floor()),
  ]),
  2: LevelOptions(minWinningScore: 30, wallsCoordinates: [
    Coordinates(y: (BOARD_SIZE / 2).floor() - 9, x: (BOARD_SIZE / 3).floor()),
    Coordinates(y: (BOARD_SIZE / 2).floor() - 8, x: (BOARD_SIZE / 3).floor()),
    Coordinates(y: (BOARD_SIZE / 2).floor() - 6, x: (BOARD_SIZE / 3).floor()),
    Coordinates(y: (BOARD_SIZE / 2).floor() - 7, x: (BOARD_SIZE / 3).floor()),
    Coordinates(y: (BOARD_SIZE / 2).floor() - 5, x: (BOARD_SIZE / 3).floor()),
    Coordinates(y: (BOARD_SIZE / 2).floor() - 4, x: (BOARD_SIZE / 3).floor()),
    Coordinates(y: (BOARD_SIZE / 2).floor() - 3, x: (BOARD_SIZE / 3).floor()),
    Coordinates(y: (BOARD_SIZE / 2).floor() - 2, x: (BOARD_SIZE / 3).floor()),
    Coordinates(y: (BOARD_SIZE / 2).floor() - 1, x: (BOARD_SIZE / 3).floor()),
    Coordinates(y: (BOARD_SIZE / 2).floor(), x: (BOARD_SIZE / 3).floor()),
    Coordinates(y: (BOARD_SIZE / 2).floor() + 9, x: (BOARD_SIZE / 3).floor()),
    Coordinates(y: (BOARD_SIZE / 2).floor() + 8, x: (BOARD_SIZE / 3).floor()),
    Coordinates(y: (BOARD_SIZE / 2).floor() + 7, x: (BOARD_SIZE / 3).floor()),
    Coordinates(y: (BOARD_SIZE / 2).floor() + 6, x: (BOARD_SIZE / 3).floor()),
    Coordinates(y: (BOARD_SIZE / 2).floor() + 5, x: (BOARD_SIZE / 3).floor()),
    Coordinates(y: (BOARD_SIZE / 2).floor() + 4, x: (BOARD_SIZE / 3).floor()),
    Coordinates(y: (BOARD_SIZE / 2).floor() + 3, x: (BOARD_SIZE / 3).floor()),
    Coordinates(y: (BOARD_SIZE / 2).floor() + 2, x: (BOARD_SIZE / 3).floor()),
    Coordinates(y: (BOARD_SIZE / 2).floor() + 1, x: (BOARD_SIZE / 3).floor()),
    Coordinates(
        y: (BOARD_SIZE / 2).floor() - 9, x: (BOARD_SIZE / 3 * 2).floor()),
    Coordinates(
        y: (BOARD_SIZE / 2).floor() - 8, x: (BOARD_SIZE / 3 * 2).floor()),
    Coordinates(
        y: (BOARD_SIZE / 2).floor() - 6, x: (BOARD_SIZE / 3 * 2).floor()),
    Coordinates(
        y: (BOARD_SIZE / 2).floor() - 7, x: (BOARD_SIZE / 3 * 2).floor()),
    Coordinates(
        y: (BOARD_SIZE / 2).floor() - 5, x: (BOARD_SIZE / 3 * 2).floor()),
    Coordinates(
        y: (BOARD_SIZE / 2).floor() - 4, x: (BOARD_SIZE / 3 * 2).floor()),
    Coordinates(
        y: (BOARD_SIZE / 2).floor() - 3, x: (BOARD_SIZE / 3 * 2).floor()),
    Coordinates(
        y: (BOARD_SIZE / 2).floor() - 2, x: (BOARD_SIZE / 3 * 2).floor()),
    Coordinates(
        y: (BOARD_SIZE / 2).floor() - 1, x: (BOARD_SIZE / 3 * 2).floor()),
    Coordinates(y: (BOARD_SIZE / 2).floor(), x: (BOARD_SIZE / 3 * 2).floor()),
    Coordinates(
        y: (BOARD_SIZE / 2).floor() + 9, x: (BOARD_SIZE / 3 * 2).floor()),
    Coordinates(
        y: (BOARD_SIZE / 2).floor() + 8, x: (BOARD_SIZE / 3 * 2).floor()),
    Coordinates(
        y: (BOARD_SIZE / 2).floor() + 7, x: (BOARD_SIZE / 3 * 2).floor()),
    Coordinates(
        y: (BOARD_SIZE / 2).floor() + 6, x: (BOARD_SIZE / 3 * 2).floor()),
    Coordinates(
        y: (BOARD_SIZE / 2).floor() + 5, x: (BOARD_SIZE / 3 * 2).floor()),
    Coordinates(
        y: (BOARD_SIZE / 2).floor() + 4, x: (BOARD_SIZE / 3 * 2).floor()),
    Coordinates(
        y: (BOARD_SIZE / 2).floor() + 3, x: (BOARD_SIZE / 3 * 2).floor()),
    Coordinates(
        y: (BOARD_SIZE / 2).floor() + 2, x: (BOARD_SIZE / 3 * 2).floor()),
    Coordinates(
        y: (BOARD_SIZE / 2).floor() + 1, x: (BOARD_SIZE / 3 * 2).floor()),
  ]),
};

import 'package:flutter/material.dart';
import 'package:snake_game/ecs/components/position.dart';
import 'package:snake_game/ecs/components/renderable.dart';
import 'package:snake_game/ecs/entities/entity.dart';
import 'package:snake_game/ecs/systems/init.dart';

class BoardEntity extends Entity with RenderableComponent {
  BoardEntity() {
    this.paint = (double boardSquareSize) {
      final List<PositionedOnBoard> gridElements = [];

      for (int row = 0; row < BOARD_SIZE; row++) {
        for (int column = 0; column < BOARD_SIZE; column++) {
          Color color;
          if (row % 2 == 0) {
            if (column % 2 == 0) {
              color = Colors.grey[850];
            } else {
              color = Colors.grey[900];
            }
          } else {
            if (column % 2 == 0) {
              color = Colors.grey[900];
            } else {
              color = Colors.grey[850];
            }
          }
          gridElements.add(
            PositionedOnBoard(
              key: Key('grid_$row$column'),
              origin: Coordinates(x: column, y: row),
              boardSquareSize: boardSquareSize,
              child: Container(color: color),
            ),
          );
        }
      }

      return gridElements;
    };
  }
}

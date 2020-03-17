import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snake_game/ecs/components/renderable.dart';
import 'package:snake_game/ecs/systems/init.dart';
import 'package:snake_game/ecs/systems/main.dart';

class GameBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final gameSystem = Provider.of<GameSystem>(context, listen: true);

    if (gameSystem.gameStatus == GameStatus.gameOver) {
      Future.delayed(Duration.zero, () => _gameOver(context));
    }
    final minimumHeight = kIsWeb
        ? MediaQuery.of(context).size.height * 0.8
        : MediaQuery.of(context).size.height * 0.5;

    final boardPixelSize =
        min(minimumHeight, MediaQuery.of(context).size.width);
    final boardSize = Size.square(boardPixelSize);
    final boardSquareSize = (boardPixelSize / BOARD_SIZE).floorToDouble();

    final renderableEntities = gameSystem.renderableEntities;
    final entityPainters = renderableEntities.map((entity) {
      return CustomPaint(
        size: boardSize,
        painter: EntityPainter(
          boardSquareSize: boardSquareSize,
          entity: entity,
        ),
      );
    }).toList();

    return Container(
      color: Colors.black,
      height: boardPixelSize,
      width: boardPixelSize,
      child: Stack(
        children: entityPainters,
      ),
    );
  }

  Future<void> _gameOver(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Text(
              'Game Over!',
              style: TextStyle(
                color: Colors.redAccent,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          backgroundColor: Colors.transparent,
        );
      },
    );
  }
}

class EntityPainter extends CustomPainter {
  dynamic entity;
  double boardSquareSize;

  EntityPainter({
    this.entity,
    this.boardSquareSize,
  }) : assert(entity is RenderableComponent);

  @override
  void paint(Canvas canvas, Size size) {
    entity.paint(canvas, boardSquareSize);
  }

  @override
  bool shouldRepaint(EntityPainter oldDelegate) {
    return entity.shouldRepaint(oldDelegate.entity);
  }
}

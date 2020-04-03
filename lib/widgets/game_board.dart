import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    final boardSquareSize =
        boardPixelSize / gameSystem?.optionsSystem?.boardSize;
    return SizedBox(
      height: boardPixelSize,
      width: boardPixelSize,
      child: ClipRect(
        clipper: BoardRect(boardPixelSize),
        child: Stack(
          children: gameSystem.renderEntities(boardSquareSize),
        ),
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

class BoardRect extends CustomClipper<Rect> {
  double boardPixelSize;

  BoardRect(this.boardPixelSize);

  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(0.0, 0.0, boardPixelSize, boardPixelSize);
  }

  @override
  bool shouldReclip(BoardRect oldClipper) {
    return boardPixelSize != oldClipper.boardPixelSize;
  }
}

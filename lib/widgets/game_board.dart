import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snake_game/ecs/components/position.dart';
import 'package:snake_game/ecs/systems/main.dart';

class GameBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final gameSystem = Provider.of<GameSystem>(context, listen: true);

    if (gameSystem.gameStatus == GameStatus.gameOver) {
      Future.delayed(Duration.zero, () => _gameOver(context));
    }

    return Container(
      color: Colors.black,
      height: MediaQuery.of(context).size.height * 0.50,
      child: CustomPaint(
        size: Size.infinite,
        painter: BoardPainter(
            boardSquareSize:
                (MediaQuery.of(context).size.height * 0.50 / BOARD_SIZE)
                    .floorToDouble(),
            appleCoordinates: gameSystem.apple?.leadPosition,
            snakeCoordinates: gameSystem.snake?.leadPosition,
            wallsCoordinates:
                gameSystem.walls?.map((wall) => wall.leadPosition)?.toList(),
            snakeBody: gameSystem.snake?.body),
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

class BoardPainter extends CustomPainter {
  Coordinates snakeCoordinates;
  Coordinates appleCoordinates;
  List<Coordinates> wallsCoordinates;
  List<Coordinates> snakeBody;
  double boardSquareSize;

  BoardPainter(
      {this.snakeCoordinates,
      this.appleCoordinates,
      this.wallsCoordinates,
      this.boardSquareSize,
      this.snakeBody});

  @override
  void paint(Canvas canvas, Size size) {
    if (appleCoordinates != null) {
      this.drawRectangle(canvas, appleCoordinates, Colors.red);
    }
    if (snakeCoordinates != null) {
      this.drawRectangle(canvas, snakeCoordinates, Colors.green);
    }
    wallsCoordinates?.forEach((wallCoordinates) {
      this.drawRectangle(canvas, wallCoordinates, Colors.orange);
    });
    snakeBody?.forEach((bodyPart) {
      this.drawRectangle(canvas, bodyPart, Colors.green);
    });
  }

  drawRectangle(canvas, Coordinates coordinates, Color color) {
    canvas.drawRect(
        Rect.fromCenter(
          width: 20,
          height: 20,
          center: Offset(
            (coordinates.x + 0.5) * this.boardSquareSize,
            (coordinates.y + 0.5) * this.boardSquareSize,
          ),
        ),
        Paint()
          ..color = color
          ..style = PaintingStyle.fill);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

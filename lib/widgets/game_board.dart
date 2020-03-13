import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snake_game/ecs/components/position.dart';
import 'package:snake_game/ecs/systems/main.dart';

class GameBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final gameSystem = Provider.of<GameSystem>(context);

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
            snakeBody: gameSystem.snake?.body),
      ),
    );
  }
}

class BoardPainter extends CustomPainter {
  Coordinates snakeCoordinates;
  Coordinates appleCoordinates;
  List<Coordinates> snakeBody;
  double boardSquareSize;

  BoardPainter(
      {this.snakeCoordinates,
      this.appleCoordinates,
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

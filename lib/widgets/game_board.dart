import 'dart:math';

import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';
import 'package:provider/provider.dart';
import 'package:snake_game/ecs/components/position.dart';
import 'package:snake_game/ecs/systems/init.dart';
import 'package:snake_game/ecs/systems/main.dart';

class GameBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final gameSystem = Provider.of<GameSystem>(context, listen: true);

    if (gameSystem.gameStatus == GameStatus.gameOver) {
      Future.delayed(Duration.zero, () => _gameOver(context));
    }

    final boardPixelSize = min(MediaQuery.of(context).size.height * 0.5,
        MediaQuery.of(context).size.width);

    return Container(
      color: Colors.black,
      height: boardPixelSize,
      width: boardPixelSize,
      child: CustomPaint(
        size: Size.square(boardPixelSize),
        painter: BoardPainter(
            boardSquareSize: (boardPixelSize / BOARD_SIZE).floorToDouble(),
            appleCoordinates: gameSystem.apple?.leadPosition,
            snakeCoordinates: gameSystem.snake?.leadPosition,
            wallsCoordinates:
                gameSystem.walls?.map((wall) => wall.leadPosition)?.toList(),
            portalsCoordinates: gameSystem.portals
                ?.map((portal) => portal.leadPosition)
                ?.toList(),
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
  List<Coordinates> portalsCoordinates;
  double boardSquareSize;

  BoardPainter(
      {this.snakeCoordinates,
      this.appleCoordinates,
      this.wallsCoordinates,
      this.boardSquareSize,
      this.snakeBody,
      this.portalsCoordinates});

  @override
  void paint(Canvas canvas, Size size) {
    if (appleCoordinates != null) {
      _drawApple(canvas, appleCoordinates);
    }
    if (snakeCoordinates != null) {
      _drawRectangle(canvas, snakeCoordinates, Colors.green);
    }
    wallsCoordinates?.forEach((wallCoordinates) {
      this.drawRectangle(canvas, wallCoordinates, Colors.orange);
    });
    portalsCoordinates?.forEach((portalCoordinates) {
      this.drawRectangle(canvas, portalCoordinates, Colors.blue);
    });
    snakeBody?.forEach((bodyPart) {
      _drawRectangle(canvas, bodyPart, Colors.green);
    });
  }

  _drawRectangle(Canvas canvas, Coordinates coordinates, Color color) {
    canvas.drawRect(
        Rect.fromCenter(
          width: this.boardSquareSize,
          height: this.boardSquareSize,
          center: Offset(
            (coordinates.x.toDouble() + 0.5) * this.boardSquareSize,
            (coordinates.y.toDouble() + 0.5) * this.boardSquareSize,
          ),
        ),
        Paint()
          ..color = color
          ..style = PaintingStyle.fill);
  }

  _drawApple(Canvas canvas, Coordinates coordinates) {
    const APPLE_LEAF_PATH =
        'M253.483,120.441c-72.72,6.416-126.336-47.216-119.936-119.92 C206.267-5.895,259.883,47.737,253.483,120.441z';
    const APPLE_TAIL_2 =
        'M256.267,171.097c-6.272-1.568-11.2-6.88-11.952-13.68c-3.44-31.152,5.472-61.76,25.056-86.208 c19.6-24.448,47.552-39.808,78.688-43.232c8.736-0.944,16.576,5.344,17.52,14.064c0.96,8.72-5.328,16.56-14.048,17.536 c-22.704,2.496-43.072,13.68-57.36,31.504s-20.768,40.128-18.272,62.832c0.96,8.736-5.328,16.576-14.064,17.552 C259.915,171.689,258.043,171.545,256.267,171.097z';
    const APPLE_BODY_PATH =
        'M374.075,120.249c-17.344-4.624-35.28-3.664-52.88,2c-45.216,14.576-93.296,14.576-138.512,0 c-17.6-5.664-35.536-6.624-52.88-2c-69.248,18.448-102.656,118.624-74.64,223.76s106.848,175.392,176.096,156.944 c0.08-0.016,0.144-0.032,0.224-0.064c13.456-3.632,27.472-3.632,40.928,0c0.08,0.016,0.144,0.032,0.224,0.064 c69.232,18.448,148.08-51.824,176.096-156.944C476.731,238.873,443.307,138.697,374.075,120.249z';
    const APPLE_SHADOW_PATH =
        'M448.715,343.993c-28,105.12-106.88,175.36-176.16,156.96h-0.16c-13.44-3.68-27.52-3.68-40.96,0 h-0.16c-26.08,6.88-53.44,1.28-78.88-13.92c135.84-52.48,237.6-184.96,258.88-346.4 C454.315,179.193,471.115,259.993,448.715,343.993z';

    const APPLE_VIEWBOX_SIZE = 503.894;
    final scaleMatrix = Matrix4.identity()
      ..scale(boardSquareSize / APPLE_VIEWBOX_SIZE * 2,
          boardSquareSize / APPLE_VIEWBOX_SIZE * 2)
      ..setTranslationRaw(
        (coordinates.x + 0.5) * boardSquareSize,
        (coordinates.y - 0.5) * boardSquareSize,
        0,
      );

    final appleLeafPath = Path()
      ..addPath(parseSvgPathData(APPLE_LEAF_PATH), Offset(0, 0),
          matrix4: scaleMatrix.storage);
    final appleTailPath = Path()
      ..addPath(parseSvgPathData(APPLE_TAIL_2), Offset(0, 0),
          matrix4: scaleMatrix.storage);
    final appleBodyPath = Path()
      ..addPath(parseSvgPathData(APPLE_BODY_PATH), Offset(0, 0),
          matrix4: scaleMatrix.storage);
    final appleShadowPath = Path()
      ..addPath(parseSvgPathData(APPLE_SHADOW_PATH), Offset(0, 0),
          matrix4: scaleMatrix.storage);

    canvas.drawPath(appleLeafPath, Paint()..color = Color(0xFF7FB241));
    canvas.drawPath(appleTailPath, Paint()..color = Color(0xFF8E6D53));
    canvas.drawPath(appleBodyPath, Paint()..color = Color(0xFFE14B4B));
    canvas.drawPath(appleShadowPath, Paint()..color = Color(0xFFD03F3F));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

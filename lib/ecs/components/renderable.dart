import 'package:flutter/material.dart';
import 'package:snake_game/ecs/components/position.dart';

mixin RenderableComponent {
  EntityPainter paint;
}

typedef EntityPainter = List<PositionedOnBoard> Function(
    double boardSquareSize);

class PositionedOnBoard extends StatelessWidget {
  final Widget child;
  final double boardSquareSize;
  final Coordinates origin;
  final double angle;
  final double scale;

  PositionedOnBoard({
    Key key,
    @required this.child,
    @required this.boardSquareSize,
    @required this.origin,
    this.angle = 0,
    this.scale = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: origin.x * boardSquareSize,
      top: origin.y * boardSquareSize,
      width: boardSquareSize,
      height: boardSquareSize,
      child: Transform.scale(
        scale: scale,
        alignment: FractionalOffset.center,
        child: Transform.rotate(
          angle: angle,
          alignment: FractionalOffset.center,
          child: child,
        ),
      ),
    );
  }
}

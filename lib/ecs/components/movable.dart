import 'package:flutter/material.dart';

class Movable {
  Speed speed;

  Movable({@required this.speed}) : assert(speed != null);
}

class Speed {
  double dx;
  double dy;

  Speed({this.dx = 0, this.dy = 0})
      : assert(dx != null),
        assert(dy != null);
}

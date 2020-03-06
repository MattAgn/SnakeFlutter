import 'package:flutter/material.dart';

class Position {
  Coordinates coordinates;

  Position({@required this.coordinates}) : assert(coordinates != null);
}

class Coordinates {
  int x;
  int y;

  Coordinates({@required this.x, @required this.y})
      : assert(x != null),
        assert(x != null);
}

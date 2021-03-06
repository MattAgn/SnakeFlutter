import 'package:flutter/material.dart';

mixin LeadPositionComponent {
  Coordinates leadPosition;
}

class Coordinates {
  int x;
  int y;

  Coordinates({@required this.x, @required this.y})
      : assert(x != null),
        assert(x != null);

  bool equal(Coordinates coordinates) {
    return this.x == coordinates.x && this.y == coordinates.y;
  }
}

import 'package:flutter/material.dart';

class PositionsComponent {
  List<Coordinates> coordinatesList;
}

class Coordinates {
  double x;
  double y;

  Coordinates({@required this.x, @required this.y})
      : assert(x != null),
        assert(x != null);
}

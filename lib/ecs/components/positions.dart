import 'package:flutter/material.dart';

class LeadPositionComponent {
  Coordinates leadPosition;
}

class Coordinates {
  double x;
  double y;

  Coordinates({@required this.x, @required this.y})
      : assert(x != null),
        assert(x != null);
}

import 'package:flutter/material.dart';
import 'package:snake_game/ecs/components/component.dart';

class Position extends Component {
  Coordinates coordinates;

  Position({@required this.coordinates}) : assert(coordinates != null);
}

class Coordinates {
  int x;
  int y;

  Coordinates({@required this.x, @required this.y})
      : assert(x != null),
        assert(y != null);
}

import 'package:flutter/material.dart';
import 'package:snake_game/ecs/components/component.dart';

class Movable extends Component {
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

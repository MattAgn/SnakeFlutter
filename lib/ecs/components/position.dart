import 'package:flutter/material.dart';
import 'package:snake_game/ecs/components/component.dart';

class Positions extends Component {
  List<Coordinates> coordinatesList;

  Positions({@required this.coordinatesList}) : assert(coordinatesList != null);
}

class Coordinates {
  int x;
  int y;

  Coordinates({@required this.x, @required this.y})
      : assert(x != null),
        assert(x != null);
}

import 'package:flutter/material.dart';
import 'package:snake_game/ecs/components/position.dart';
import 'package:snake_game/ecs/components/eatable.dart';

class Apple {
  Position position;
  Eatable eatable;

  Apple({@required this.position, @required this.eatable})
      : assert(position != null),
        assert(eatable != null);
}

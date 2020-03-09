import 'package:snake_game/ecs/components/controllable.dart';
import 'package:snake_game/ecs/components/eater.dart';
import 'package:snake_game/ecs/components/movable.dart';
import 'package:snake_game/ecs/components/not_eatabable.dart';
import 'package:snake_game/ecs/components/positions.dart';
import 'package:snake_game/ecs/entities/entity.dart';

class SnakeEntity extends Entity
    with
        MovableComponent,
        ControllableComponent,
        PositionsComponent,
        NotEatableComponent,
        EaterComponent {}

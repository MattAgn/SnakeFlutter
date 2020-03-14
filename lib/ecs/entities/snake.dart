import 'package:snake_game/ecs/components/body.dart';
import 'package:snake_game/ecs/components/controllable.dart';
import 'package:snake_game/ecs/components/eater.dart';
import 'package:snake_game/ecs/components/movable.dart';
import 'package:snake_game/ecs/components/not_eatable.dart';
import 'package:snake_game/ecs/components/position.dart';
import 'package:snake_game/ecs/entities/entity.dart';

class SnakeEntity extends Entity
    with
        MovableComponent,
        BodyComponent,
        ControllableComponent,
        LeadPositionComponent,
        NotEatableComponent,
        EaterComponent {
  SnakeEntity(Coordinates initialLeadPosition, Speed speed) {
    this.body = [];
    this.leadPosition = initialLeadPosition;
  }
}

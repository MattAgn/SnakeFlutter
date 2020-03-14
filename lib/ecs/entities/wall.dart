import 'package:snake_game/ecs/components/not_eatable.dart';
import 'package:snake_game/ecs/components/position.dart';
import 'package:snake_game/ecs/entities/entity.dart';

class WallEntity extends Entity
    with NotEatableComponent, LeadPositionComponent {}

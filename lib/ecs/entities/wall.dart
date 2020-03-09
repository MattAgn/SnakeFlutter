import 'package:snake_game/ecs/components/not_eatabable.dart';
import 'package:snake_game/ecs/components/positions.dart';
import 'package:snake_game/ecs/entities/entity.dart';

class WallEntity extends Entity with NotEatableComponent, PositionsComponent {}

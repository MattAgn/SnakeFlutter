import 'package:snake_game/ecs/components/eatable.dart';
import 'package:snake_game/ecs/components/positions.dart';
import 'package:snake_game/ecs/entities/entity.dart';

class AppleEntity extends Entity with LeadPositionComponent, EatableComponent {
  AppleEntity(Coordinates initialApplePosition) {
    this.leadPosition = initialApplePosition;
  }
}

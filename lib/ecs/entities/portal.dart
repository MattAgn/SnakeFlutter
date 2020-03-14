import 'package:snake_game/ecs/components/exit_position.dart';
import 'package:snake_game/ecs/components/position.dart';
import 'package:snake_game/ecs/entities/entity.dart';

class PortalEntity extends Entity
    with LeadPositionComponent, ExitPositionComponent {
  PortalEntity(Coordinates leadPosition, Coordinates exitPosition) {
    this.exitPosition = exitPosition;
    this.leadPosition = leadPosition;
  }
}

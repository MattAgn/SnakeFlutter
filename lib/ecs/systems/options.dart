import 'package:snake_game/ecs/systems/system.dart';

class OptionsSystem extends System {
  int nbRandomWalls = 0;
  int nbRandomPortals = 0;

  /// default board surroundings is portals
  bool shouldSurroundBoardWithWalls = false;
}

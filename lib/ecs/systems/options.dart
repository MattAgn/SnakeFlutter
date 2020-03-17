import 'package:snake_game/ecs/entities/portal.dart';
import 'package:snake_game/ecs/entities/wall.dart';
import 'package:snake_game/ecs/systems/system.dart';

class OptionsSystem extends System {
  int _nbRandomWalls = 0;
  int _nbRandomPortals = 0;
  Function notifyGameListeners;

  /// default = [portalEntity:true, wallEntity: false]
  List<bool> surroundingBoardEntityTypesSelected = [true, false];

  OptionsSystem({this.notifyGameListeners});

  selectSurroundingEntityType(int index) {
    for (int buttonIndex = 0;
        buttonIndex < surroundingBoardEntityTypesSelected.length;
        buttonIndex++) {
      if (buttonIndex == index) {
        surroundingBoardEntityTypesSelected[buttonIndex] = true;
      } else {
        surroundingBoardEntityTypesSelected[buttonIndex] = false;
      }
    }
    this.notifyGameListeners();
  }

  get surroundingBoardEntityType =>
      surroundingBoardEntityTypesSelected[0] ? PortalEntity : WallEntity;

  set nbRandomWalls(int nbRandomWalls) {
    _nbRandomWalls = nbRandomWalls;
    notifyGameListeners();
  }

  set nbRandomPortals(int nbRandomPortals) {
    _nbRandomPortals = nbRandomPortals;
    notifyGameListeners();
  }

  get nbRandomWalls => _nbRandomWalls;

  get nbRandomPortals => _nbRandomPortals;
}

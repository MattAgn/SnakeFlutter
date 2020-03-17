import 'package:snake_game/ecs/entities/portal.dart';
import 'package:snake_game/ecs/entities/wall.dart';
import 'package:snake_game/ecs/systems/system.dart';

class OptionsSystem extends System {
  int nbRandomWalls = 0;
  int nbRandomPortals = 0;
  Function notifyListener;

  /// default = [portalEntity:true, wallEntity: false]
  List<bool> surroundingBoardEntityTypesSelected = [true, false];

  OptionsSystem({this.notifyListener});

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
    this.notifyListener();
  }

  get surroundingBoardEntityType =>
      surroundingBoardEntityTypesSelected[0] ? PortalEntity : WallEntity;
}

import 'package:snake_game/ecs/components/position.dart';
import 'package:snake_game/ecs/entities/portal.dart';
import 'package:snake_game/ecs/entities/wall.dart';
import 'package:snake_game/ecs/systems/system.dart';

class OptionsSystem extends System {
  Function notifyGameListeners;
  List<Coordinates> wallsCoordinates = [];
  int minWinningScore;
  int _nbRandomWalls = 0;
  int _nbRandomPortals = 0;
  int _boardSize = 10;

  /// inverse of the time in milliseconds between 2 iterations of the game loop
  double _gameSpeed = 1 / 100;

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

  set surroundingBoardEntityType(Type surroundingBoardEntityType) {
    surroundingBoardEntityTypesSelected =
        surroundingBoardEntityType == PortalEntity
            ? [true, false]
            : [false, true];
  }

  Type get surroundingBoardEntityType =>
      surroundingBoardEntityTypesSelected[0] ? PortalEntity : WallEntity;

  set nbRandomWalls(int nbRandomWalls) {
    _nbRandomWalls = nbRandomWalls;
    notifyGameListeners();
  }

  set nbRandomPortals(int nbRandomPortals) {
    _nbRandomPortals = nbRandomPortals;
    notifyGameListeners();
  }

  set boardSize(int boardSize) {
    _boardSize = boardSize;
    notifyGameListeners();
  }

  set gameSpeed(double gameSpeed) {
    _gameSpeed = gameSpeed;
    notifyGameListeners();
  }

  int get nbRandomWalls => _nbRandomWalls;

  int get nbRandomPortals => _nbRandomPortals;

  double get gameSpeed => _gameSpeed;

  int get boardSize => _boardSize;
}

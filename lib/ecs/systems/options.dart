import 'package:snake_game/ecs/components/position.dart';
import 'package:snake_game/ecs/entities/portal.dart';
import 'package:snake_game/ecs/entities/wall.dart';
import 'package:snake_game/ecs/systems/system.dart';

class OptionsSystem extends System {
  Function notifyGameListeners;
  int _nbRandomWalls = 0;
  int _nbRandomPortals = 0;
  int _boardSize = 30;
  List<Coordinates> _wallsCoordinates = [];
  int _minWinningScore;

  /// time in milliseconds between 2 iterations of the game loop
  int _gameSpeed = 100;

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

  set boardSize(int boardSize) {
    _boardSize = boardSize;
    notifyGameListeners();
  }

  set gameSpeed(int gameSpeed) {
    _gameSpeed = gameSpeed;
    notifyGameListeners();
  }

  get nbRandomWalls => _nbRandomWalls;

  get nbRandomPortals => _nbRandomPortals;

  get gameSpeed => _gameSpeed;

  get boardSize => _boardSize;

  get minWinningScore => _minWinningScore;

  get wallsCoordinates => _wallsCoordinates;
}

mixin ControllerComponent {
  /// list of direction instructions for a movable entity,
  /// the first direction of the list is the next one that will be applied,
  /// once a direction is done, it is taken out of the list,
  /// a new instruction of direction is added at the end of the list
  List<Direction> nextDirections = [];
  Direction currentDirection = Direction.right;

  set direction(Direction newDirection) {
    if (nextDirections.length == 0 &&
        isDirectionAllowed(currentDirection, newDirection)) {
      nextDirections.add(newDirection);
    } else if (nextDirections.length > 0 &&
        isDirectionAllowed(nextDirections.last, newDirection)) {
      nextDirections.add(newDirection);
    }
  }

  getDirectionToApply() {
    if (nextDirections.length > 0) {
      currentDirection = nextDirections.removeAt(0);
    }
    return currentDirection;
  }

  static bool isDirectionAllowed(
      Direction previousDirection, Direction newDirection) {
    // by default, the direction already stays the same if the user does nothing
    // we don't want duplicates directions instructions
    if (previousDirection == newDirection) return false;

    return ((newDirection == Direction.down &&
            previousDirection != Direction.up) ||
        (newDirection == Direction.up && previousDirection != Direction.down) ||
        (newDirection == Direction.right &&
            previousDirection != Direction.left) ||
        (newDirection == Direction.left &&
            previousDirection != Direction.right));
  }
}

enum Direction { up, down, right, left }

class MovableComponent {
  Speed speed = Speed();
}

class Speed {
  double dx;
  double dy;

  Speed({this.dx = 0, this.dy = 0})
      : assert(dx != null),
        assert(dy != null);
}

import 'package:flutter/material.dart';
import 'package:snake_game/ecs/entities/entity.dart';

mixin RenderableComponent<T extends Entity> {
  PaintFunction paint;
  ShouldRepaintFunction<T> shouldRepaint;
}

typedef PaintFunction = void Function(Canvas canvas, double boardSquareSize);

typedef ShouldRepaintFunction<T> = bool Function(T previousEntityState);

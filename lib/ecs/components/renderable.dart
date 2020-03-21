import 'package:flutter/material.dart';

mixin RenderableComponent {
  PaintFunction paint;
  ShouldRepaintFunction shouldRepaint;
  Map<String, dynamic> get renderData;
}

typedef PaintFunction = void Function(Canvas canvas, double boardSquareSize);

typedef ShouldRepaintFunction = bool Function(
    Map<String, dynamic> previousRenderData);

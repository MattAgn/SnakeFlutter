import 'dart:math';

import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';
import 'package:snake_game/ecs/components/not_eatable.dart';
import 'package:snake_game/ecs/components/position.dart';
import 'package:snake_game/ecs/components/renderable.dart';
import 'package:snake_game/ecs/entities/entity.dart';
import 'package:snake_game/ecs/systems/init.dart';

class WallEntity extends Entity
    with NotEatableComponent, LeadPositionComponent, RenderableComponent {
  WallEntity(Coordinates initialLeadPosition) {
    this.leadPosition = initialLeadPosition;

    paint = (Canvas canvas, double boardSquareSize) {
      final scaleRatio = boardSquareSize / _svgViewBox;
      final isVerticalWall =
          leadPosition.x == 0 || leadPosition.x == BOARD_SIZE;
      final scaleMatrix = Matrix4.identity()
        ..scale(scaleRatio, scaleRatio)
        ..setTranslationRaw(
          leadPosition.x * boardSquareSize +
              (isVerticalWall ? boardSquareSize : 0),
          leadPosition.y * boardSquareSize,
          0,
        )
        ..rotateZ(isVerticalWall ? pi / 2 : 0);

      for (final svgRect in _svgRects) {
        final brickPath = Path()
          ..addPath(
              Path()
                ..addRect(Rect.fromLTWH(
                    svgRect['x'].toDouble(),
                    svgRect['y'].toDouble(),
                    svgRect['width'].toDouble(),
                    svgRect['height'].toDouble())),
              Offset(0, 0),
              matrix4: scaleMatrix.storage);
        canvas.drawPath(brickPath, Paint()..color = Color(svgRect['fill']));
      }

      final wallPath = Path()
        ..addPath(parseSvgPathData(_svgPath), Offset(0, 0),
            matrix4: scaleMatrix.storage);

      canvas.drawPath(wallPath, Paint()..color = Color(0xFF2E2D31));
    };

    shouldRepaint = (previousWallData) {
      return leadPosition.x != previousWallData['x'] ||
          leadPosition.y != previousWallData['y'];
    };
  }

  get renderData => {
        'x': leadPosition.x,
        'y': leadPosition.y,
      };

  static const _svgViewBox = 512.0;

  static const _svgPath =
      'M502.747,74.024H9.253C4.142,74.024,0,78.166,0,83.277v345.446c0,5.111,4.142,9.253,9.253,9.253 h493.494c5.111,0,9.253-4.142,9.253-9.253V83.277C512,78.166,507.858,74.024,502.747,74.024z M363.952,333.108v-67.855h129.542 v67.855H363.952z M166.554,333.108v-67.855h178.892v67.855H166.554z M18.506,333.108v-67.855h129.542v67.855H18.506z M246.747,178.892v67.855H67.855v-67.855H246.747z M444.145,178.892v67.855H265.253v-67.855H444.145z M493.494,178.892v67.855 h-30.843v-67.855H493.494z M49.349,246.747H18.506v-67.855h30.843V246.747z M493.494,160.386H363.952V92.53h129.542V160.386z M345.446,92.53v67.855H166.554V92.53H345.446z M148.048,92.53v67.855H18.506V92.53H148.048z M18.506,351.614h30.843v67.855H18.506 V351.614z M67.855,351.614h178.892v67.855H67.855V351.614z M265.253,419.47v-67.855h178.892v67.855H265.253z M462.651,419.47 v-67.855h30.843v67.855H462.651z';

  static const _svgRects = [
    {
      'x': 9.253,
      'y': 83.277,
      'fill': 0xFFF7E3C6,
      'width': 246.747,
      'height': 345.446,
    },
    {
      'x': 256,
      'y': 83.277,
      'fill': 0xFFEFC27B,
      'width': 246.747,
      'height': 345.446,
    },
    {
      'x': 256,
      'y': 342.361,
      'fill': 0xFFEFC27B,
      'width': 197.398,
      'height': 86.361,
    },
    {
      'x': 157.301,
      'y': 256,
      'fill': 0xFFF7E3C6,
      'width': 197.398,
      'height': 86.361,
    },
    {
      'x': 157.301,
      'y': 83.277,
      'fill': 0xFFF7E3C6,
      'width': 197.398,
      'height': 86.361,
    },
    {
      'x': 256,
      'y': 83.277,
      'fill': 0xFFF4D8AA,
      'width': 98.699,
      'height': 86.361,
    },
    {
      'x': 256,
      'y': 256,
      'fill': 0xFFF4D8AA,
      'width': 98.699,
      'height': 86.361,
    },
    {
      'x': 9.253,
      'y': 83.277,
      'fill': 0xFFEFC27B,
      'width': 148.048,
      'height': 86.361,
    },
    {
      'x': 354.699,
      'y': 83.277,
      'fill': 0xFFECB45C,
      'width': 148.048,
      'height': 86.361,
    },
    {
      'x': 9.253,
      'y': 256,
      'fill': 0xFFEFC27B,
      'width': 148.048,
      'height': 86.361,
    },
    {
      'x': 354.699,
      'y': 256,
      'fill': 0xFFECB45C,
      'width': 148.048,
      'height': 86.361,
    },
    {
      'x': 453.398,
      'y': 342.361,
      'fill': 0xFFE9A440,
      'width': 49.349,
      'height': 86.361,
    },
    {
      'x': 453.398,
      'y': 169.639,
      'fill': 0xFFE9A440,
      'width': 49.349,
      'height': 86.361,
    },
    {
      'x': 58.602,
      'y': 342.361,
      'fill': 0xFFF4D8AA,
      'width': 197.398,
      'height': 86.361,
    },
    {
      'x': 256,
      'y': 169.639,
      'fill': 0xFFEFC27B,
      'width': 197.398,
      'height': 86.361,
    },
    {
      'x': 58.602,
      'y': 169.639,
      'fill': 0xFFF4D8AA,
      'width': 197.398,
      'height': 86.361,
    },
  ];
}

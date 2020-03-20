import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';
import 'package:snake_game/ecs/components/body.dart';
import 'package:snake_game/ecs/components/controllable.dart';
import 'package:snake_game/ecs/components/eater.dart';
import 'package:snake_game/ecs/components/movable.dart';
import 'package:snake_game/ecs/components/not_eatable.dart';
import 'package:snake_game/ecs/components/position.dart';
import 'package:snake_game/ecs/components/renderable.dart';
import 'package:snake_game/ecs/entities/entity.dart';

class SnakeEntity extends Entity
    with
        MovableComponent,
        BodyComponent,
        ControllableComponent,
        LeadPositionComponent,
        NotEatableComponent,
        EaterComponent,
        RenderableComponent {
  SnakeEntity(Coordinates initialLeadPosition, Speed speed) {
    this.body = [];
    this.leadPosition = initialLeadPosition;

    paint = (Canvas canvas, double boardSquareSize) {
      // Draw body
      if (body.isNotEmpty) {
        for (final bodyPart in body.reversed.skip(1)) {
          canvas.drawRect(
              Rect.fromLTWH(
                bodyPart.x.toDouble() * boardSquareSize,
                bodyPart.y.toDouble() * boardSquareSize,
                boardSquareSize,
                boardSquareSize,
              ),
              Paint()..color = Color(0xFFA0C432));

          canvas.drawRect(
              Rect.fromLTWH(
                bodyPart.x.toDouble() * boardSquareSize,
                bodyPart.y.toDouble() * boardSquareSize,
                movingHorizontally ? boardSquareSize / 8 : boardSquareSize,
                movingVertically ? boardSquareSize / 8 : boardSquareSize,
              ),
              Paint()..color = Color(0xFF779226));
          canvas.drawRect(
              Rect.fromLTWH(
                bodyPart.x.toDouble() * boardSquareSize,
                bodyPart.y.toDouble() * boardSquareSize,
                movingVertically ? boardSquareSize / 8 : boardSquareSize,
                movingHorizontally ? boardSquareSize / 8 : boardSquareSize,
              ),
              Paint()..color = Color(0xFF779226));
        }
        final lastBodyPart = body.last;
        canvas.drawOval(
            Rect.fromLTWH(
              (lastBodyPart.x.toDouble() - 0.5 * sin(rotation)) *
                  boardSquareSize,
              (lastBodyPart.y.toDouble() + 0.5 * cos(rotation)) *
                  boardSquareSize,
              boardSquareSize,
              boardSquareSize,
            ),
            Paint()..color = Color(0xFF779226));
      }

      // Draw head
      final scaleRatio = boardSquareSize / _svgViewBox * 2;
      final scaleMatrix = Matrix4.identity()
        ..scale(scaleRatio, scaleRatio)
        ..setTranslationRaw(
          (leadPosition.x + 0.5 - cos(rotation) + sin(rotation)) *
              boardSquareSize,
          (leadPosition.y + 0.5 - sin(rotation) - cos(rotation)) *
              boardSquareSize,
          0,
        )
        ..rotateZ(rotation);

      for (final svgPath in _svgPaths) {
        final subPath = Path()
          ..addPath(parseSvgPathData(svgPath['path']), Offset(0, 0),
              matrix4: scaleMatrix.storage);

        final paint = Paint();
        if (svgPath['fill'] != null) {
          paint..color = Color(svgPath['fill']);
        } else {
          paint
            ..style = PaintingStyle.stroke
            ..color = Colors.black;
        }

        canvas.drawPath(subPath, paint);
      }

      for (final svgPolyline in _svgPolylines) {
        final subPath = Path()
          ..addPath(
              Path()
                ..addPolygon(
                  svgPolyline['points'],
                  false,
                ),
              Offset(0, 0),
              matrix4: scaleMatrix.storage);

        canvas.drawPath(subPath, Paint()..color = Color(svgPolyline['fill']));
      }
    };

    shouldRepaint = (previousSnakeData) {
      return leadPosition.x != previousSnakeData['x'] ||
          leadPosition.y != previousSnakeData['y'];
    };
  }

  get renderData => {
        'x': leadPosition.x,
        'y': leadPosition.y,
      };

  double get rotation {
    return atan2(speed.dy, speed.dx) - pi / 2;
  }

  bool get movingVertically {
    return speed.dy.abs() > 0;
  }

  bool get movingHorizontally {
    return speed.dx.abs() > 0;
  }

  static const _svgPolylines = [
    {
      'fill': 0xFFE71B3F,
      'points': [
        Offset(271.856, 438.932),
        Offset(240.134, 438.932),
        Offset(240.134, 362.349),
        Offset(271.856, 362.349),
        Offset(271.856, 438.932)
      ],
    },
    {
      'fill': 0xFFE71B3F,
      'points': [
        Offset(292.877, 512),
        Offset(256.001, 464.722),
        Offset(219.123, 512),
        Offset(194.112, 492.49),
        Offset(256.001, 413.148),
        Offset(317.889, 492.49),
        Offset(292.877, 512)
      ],
    },
    {
      'fill': 0xFFAB142F,
      'points': [
        Offset(271.856, 362.349),
        Offset(255.996, 362.349),
        Offset(255.996, 413.154),
        Offset(256.001, 413.148),
        Offset(271.856, 433.474),
        Offset(271.856, 377.476),
        Offset(271.856, 362.349)
      ],
    },
    {
      'fill': 0xFFAB142F,
      'points': [
        Offset(256.001, 413.148),
        Offset(255.996, 413.154),
        Offset(255.996, 464.73),
        Offset(256.001, 464.722),
        Offset(292.877, 512),
        Offset(317.889, 492.49),
        Offset(271.856, 433.474),
        Offset(256.001, 413.148)
      ],
    }
  ];

  static const _svgPaths = [
    {
      'fill': 0xFFA0C432,
      'path':
          'M256,378.209c-39.396,0-69.909-12.728-93.281-38.911c-21.525-24.116-34.173-56.533-44.635-87.971 c-4.033-12.12-7.928-22.486-11.693-32.51c-11.295-30.063-20.215-53.807-20.215-92.497c0-26.57,6.073-49.471,18.052-68.062 c10.551-16.376,25.716-29.477,45.072-38.939C184.726,2.004,227.162,0,256,0c28.837,0,71.273,2.004,106.7,19.319 c19.355,9.461,34.52,22.563,45.072,38.939c11.979,18.592,18.052,41.492,18.052,68.062c0,38.691-8.921,62.434-20.214,92.497 c-3.766,10.024-7.662,20.39-11.694,32.51c-10.462,31.438-23.11,63.855-44.634,87.971C325.908,365.482,295.395,378.209,256,378.209'
    },
    {
      'fill': 0xFF333333,
      'path':
          'M182.433,142.835c0-11.645,9.334-21.075,20.806-21.075c11.486,0,20.818,9.431,20.818,21.075 c0,11.643-9.333,21.082-20.818,21.082C191.768,163.917,182.433,154.478,182.433,142.835z'
    },
    {
      'fill': null,
      'path':
          'M329.57,142.835c0-11.73-9.396-21.239-20.963-21.239c-11.582,0-20.977,9.509-20.977,21.239s9.396,21.239,20.977,21.239 C320.174,164.074,329.57,154.566,329.57,142.835'
    },
    {
      'fill': 0xFFBDBDBF,
      'path':
          'M256.001,464.722l-0.005,0.006l0,0L256.001,464.722 M271.856,377.476L271.856,377.476v55.999 l46.033,59.015l-46.033-59.015V377.476 M348.097,340.607c-0.001,0.001-0.003,0.003-0.004,0.004 C348.095,340.609,348.095,340.609,348.097,340.607 M348.573,340.084c-0.003,0.003-0.006,0.006-0.008,0.01 C348.568,340.091,348.569,340.088,348.573,340.084 M348.822,339.809c-0.011,0.011-0.02,0.022-0.03,0.033 C348.801,339.833,348.812,339.821,348.822,339.809 M349.06,339.545c-0.008,0.009-0.017,0.018-0.025,0.027 C349.042,339.564,349.053,339.553,349.06,339.545 M256,0h-0.004C255.997,0,255.998,0,256,0c28.837,0,71.273,2.004,106.7,19.319 c19.355,9.461,34.52,22.563,45.072,38.939c11.979,18.592,18.052,41.492,18.052,68.062l0,0c0-26.57-6.073-49.471-18.052-68.062 c-10.551-16.376-25.716-29.477-45.072-38.939C327.273,2.004,284.836,0,256,0'
    },
    {
      'fill': 0xFF779226,
      'path':
          'M308.608,164.074c-11.582,0-20.977-9.509-20.977-21.239s9.395-21.239,20.977-21.239 c11.567,0,20.963,9.509,20.963,21.239S320.174,164.074,308.608,164.074 M256,0c-0.002,0-0.002,0-0.004,0c0,0,0,374.776,0,378.209 c9.66,0,15.86-0.734,15.86-0.734l0,0v-0.009c31.225-2.989,56.292-15.124,76.237-36.855c0.001-0.001,0.003-0.003,0.004-0.004 c0.155-0.169,0.313-0.342,0.467-0.513c0.003-0.003,0.006-0.006,0.008-0.01c0.073-0.08,0.146-0.161,0.219-0.241 c0.01-0.011,0.02-0.022,0.03-0.033c0.072-0.079,0.142-0.158,0.214-0.237c0.008-0.01,0.017-0.018,0.025-0.027 c0.074-0.082,0.146-0.163,0.22-0.245c21.525-24.116,34.173-56.533,44.634-87.971c4.033-12.12,7.928-22.486,11.694-32.51 c11.294-30.063,20.214-53.807,20.214-92.497c0-26.57-6.073-49.471-18.052-68.062c-10.551-16.376-25.716-29.477-45.072-38.939 C327.273,2.004,284.836,0,256,0'
    },
    {
      'fill': 0xFF333333,
      'path':
          'M308.608,121.596c-11.582,0-20.977,9.509-20.977,21.239s9.396,21.239,20.977,21.239 c11.567,0,20.963-9.509,20.963-21.239S320.174,121.596,308.608,121.596'
    },
  ];

  static const _svgViewBox = 512.0;
}

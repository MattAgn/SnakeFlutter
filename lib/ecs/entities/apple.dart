import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';
import 'package:snake_game/ecs/components/eatable.dart';
import 'package:snake_game/ecs/components/position.dart';
import 'package:snake_game/ecs/components/renderable.dart';
import 'package:snake_game/ecs/components/spawnable.dart';
import 'package:snake_game/ecs/entities/entity.dart';

class AppleEntity extends Entity
    with
        LeadPositionComponent,
        EatableComponent,
        SpanwableComponent,
        RenderableComponent {
  AppleEntity(Coordinates initialApplePosition) {
    leadPosition = initialApplePosition;

    paint = (Canvas canvas, double boardSquareSize) {
      final scaleRatio = boardSquareSize / _svgViewBox * 1.5;
      final scaleMatrix = Matrix4.identity()
        ..scale(scaleRatio, scaleRatio)
        ..setTranslationRaw(
          (leadPosition.x - 0.5) * boardSquareSize,
          (leadPosition.y - 0.5) * boardSquareSize,
          0,
        );

      final leaf = Path()
        ..addPath(parseSvgPathData(_svgPaths['leaf']), Offset(0, 0),
            matrix4: scaleMatrix.storage);
      final tail = Path()
        ..addPath(parseSvgPathData(_svgPaths['tail']), Offset(0, 0),
            matrix4: scaleMatrix.storage);
      final body = Path()
        ..addPath(parseSvgPathData(_svgPaths['body']), Offset(0, 0),
            matrix4: scaleMatrix.storage);
      final shadow = Path()
        ..addPath(parseSvgPathData(_svgPaths['shadow']), Offset(0, 0),
            matrix4: scaleMatrix.storage);

      canvas.drawPath(leaf, Paint()..color = Color(0xFF7FB241));
      canvas.drawPath(tail, Paint()..color = Color(0xFF8E6D53));
      canvas.drawPath(body, Paint()..color = Color(0xFFE14B4B));
      canvas.drawPath(shadow, Paint()..color = Color(0xFFD03F3F));
    };

    shouldRepaint = (previousAppleData) {
      return leadPosition.x != previousAppleData['x'] ||
          leadPosition.y != previousAppleData['y'];
    };
  }

  get renderData => {
        'x': leadPosition.x,
        'y': leadPosition.y,
      };

  static const _svgPaths = {
    'leaf':
        'M253.483,120.441c-72.72,6.416-126.336-47.216-119.936-119.92 C206.267-5.895,259.883,47.737,253.483,120.441z',
    'tail':
        'M256.267,171.097c-6.272-1.568-11.2-6.88-11.952-13.68c-3.44-31.152,5.472-61.76,25.056-86.208 c19.6-24.448,47.552-39.808,78.688-43.232c8.736-0.944,16.576,5.344,17.52,14.064c0.96,8.72-5.328,16.56-14.048,17.536 c-22.704,2.496-43.072,13.68-57.36,31.504s-20.768,40.128-18.272,62.832c0.96,8.736-5.328,16.576-14.064,17.552 C259.915,171.689,258.043,171.545,256.267,171.097z',
    'body':
        'M374.075,120.249c-17.344-4.624-35.28-3.664-52.88,2c-45.216,14.576-93.296,14.576-138.512,0 c-17.6-5.664-35.536-6.624-52.88-2c-69.248,18.448-102.656,118.624-74.64,223.76s106.848,175.392,176.096,156.944 c0.08-0.016,0.144-0.032,0.224-0.064c13.456-3.632,27.472-3.632,40.928,0c0.08,0.016,0.144,0.032,0.224,0.064 c69.232,18.448,148.08-51.824,176.096-156.944C476.731,238.873,443.307,138.697,374.075,120.249z',
    'shadow':
        'M448.715,343.993c-28,105.12-106.88,175.36-176.16,156.96h-0.16c-13.44-3.68-27.52-3.68-40.96,0 h-0.16c-26.08,6.88-53.44,1.28-78.88-13.92c135.84-52.48,237.6-184.96,258.88-346.4 C454.315,179.193,471.115,259.993,448.715,343.993z',
  };

  static const _svgViewBox = 503.894;
}

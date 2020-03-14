import 'package:flutter/material.dart';
import 'package:snake_game/ecs/entities/entity.dart';

class System extends ChangeNotifier {
  List<EntityType> getEntitiesByComponent<ComponentType, EntityType>(
      List<Entity> entities) {
    return entities
        .where((entity) => entity is ComponentType)
        .map((e) => e as EntityType)
        .toList();
  }

  List<EntityType>
      getEntitiesByComponents<ComponentType1, ComponentType2, EntityType>(
          List<Entity> entities) {
    return entities
        .where((entity) => entity is ComponentType1 && entity is ComponentType2)
        .map((e) => e as EntityType)
        .toList();
  }

  void handleEntities(List<Entity> entities) {}
}

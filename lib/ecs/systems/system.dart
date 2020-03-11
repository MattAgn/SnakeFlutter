import 'package:snake_game/ecs/entities/entity.dart';

class System {
  List<ComponentType> getEntitiesByComponent<ComponentType>(entities) {
    return entities.where((entity) => entity is ComponentType).toList();
  }

  getEntitiesByComponents<ComponentType1, ComponentType2, EntityType>(
      List<Entity> entities) {
    return entities
        .where((entity) => entity is ComponentType1 && entity is ComponentType2)
        .map((e) => e as EntityType)
        .toList();
  }

  handleEntities(entities) {}
}

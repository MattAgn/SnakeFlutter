import 'package:snake_game/ecs/entities/entity.dart';

class System {
  List<Entity> getEntitiesByComponent<ComponentType>(entities) {
    List<Entity> matchingEntities = [];
    entities.forEach((entity) {
      if (entity
          .getComponentTypes()
          .any((componentType) => componentType == ComponentType)) {
        matchingEntities.add(entity);
      }
    });
    return matchingEntities;
  }

  handleEntities(entities) {}
}

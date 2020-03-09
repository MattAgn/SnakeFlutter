class System {
  List<EntityType> getEntitiesByComponent<ComponentType, EntityType>(entities) {
    List<EntityType> matchingEntities = [];
    entities.forEach((entity) {
      if (entity
          .getComponentTypes()
          .any((componentType) => componentType == ComponentType)) {
        matchingEntities.add(entity);
      }
    });
    return matchingEntities;
  }

  List<EntityType>
      getEntitiesByComponents<ComponentType1, ComponentType2, EntityType>(
          entities) {
    List<EntityType> matchingEntities = [];
    entities.forEach((entity) {
      if (entity
              .getComponentTypes()
              .any((componentType) => componentType == ComponentType1) &&
          entity
              .getComponentTypes()
              .any((componentType) => componentType == ComponentType2)) {
        matchingEntities.add(entity);
      }
    });
    return matchingEntities;
  }

  handleEntities(entities) {}
}

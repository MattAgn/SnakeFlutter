class System {
  List<ComponentType> getEntitiesByComponent<ComponentType>(entities) {
    List<ComponentType> matchingEntities = [];
    entities.forEach((entity) {
      if (entity is ComponentType) {
        matchingEntities.add(entity);
      }
    });
    return matchingEntities;
  }

  List<EntityType>
      getEntitiesByComponents<ComponentType1, ComponentType2, EntityType>(
          entities) {
    final matchingEntities = [];
    entities.forEach((entity) {
      if (entity is ComponentType1 && entity is ComponentType2) {
        matchingEntities.add(entity);
      }
    });

    return matchingEntities;
  }

  handleEntities(entities) {}
}

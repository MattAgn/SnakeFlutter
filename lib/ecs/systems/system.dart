class System {
  List<ComponentType> getEntitiesByComponent<ComponentType>(entities) {
    return entities.where((entity) => entity is ComponentType);
  }

  List<EntityType>
      getEntitiesByComponents<ComponentType1, ComponentType2, EntityType>(
          entities) {
    return entities.where(
        (entity) => entity is ComponentType1 || entity is ComponentType2);
  }

  handleEntities(entities) {}
}

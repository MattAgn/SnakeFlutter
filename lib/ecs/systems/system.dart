class System {
  getEntitiesByComponent<ComponentType>(entities) {
    var matchingEntities = [];
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

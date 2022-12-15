abstract class MapperModel<M, E> {
  M toModel(E entity);
  List<M> toModels(List<E> entities) =>
      entities.map((m) => toModel(m)).toList();
}

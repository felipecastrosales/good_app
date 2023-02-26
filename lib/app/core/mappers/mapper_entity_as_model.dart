abstract class MapperEntityAsModel<E, M> {
  M toModel(E entity);
  List<M> toModels(List<E> entities) =>
      entities.map((e) => toModel(e)).toList();
}

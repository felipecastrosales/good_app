abstract class MapperEntity<E, M> {
  E toEntity(M model);
  List<E> toEntities(List<M> models) => models.map((e) => toEntity(e)).toList();
}

abstract class MapperModelAsEntity<M, E> {
  E toEntity(M model);
  List<E> toEntities(List<M> models) => models.map((e) => toEntity(e)).toList();
}

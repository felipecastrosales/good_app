abstract class MapperAsObjectAnother<O, A> {
  O toObject(A another);
  List<O> toObjects(List<A> anothers) =>
      anothers.map((o) => toObject(o)).toList();
}

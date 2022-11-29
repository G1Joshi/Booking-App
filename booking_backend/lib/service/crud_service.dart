abstract class CrudService<T> {
  Future<T> create(T t);

  Future<T?> read(String id);

  Future<List<T>> readAll();

  Future<T> update(String id, T t);

  Future<void> delete(String id);
}

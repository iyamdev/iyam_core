abstract class BaseLocalDataSource<T> {
  Future<T?> get();
  Future<void> save(T data);
  Future<void> clear();
}

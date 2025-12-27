/// Base contract for local data source (DB / cache / storage)
///
/// T = Model type
abstract class BaseLocalDataSource<T> {
  /// Get cached data
  Future<T?> get();

  /// Save data to local storage
  Future<void> save(T data);

  /// Clear cached data
  Future<void> clear();

  /// Get last updated timestamp (millisecondsSinceEpoch)
  ///
  /// Used for TTL / cache validation
  Future<int?> getUpdatedAt();
}

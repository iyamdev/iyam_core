import 'repository_result.dart';

abstract class BaseRepository<T> {
  /// Fetch data directly from remote
  Future<RepositoryResult<T>> fetch();

  /// Optional refresh hook
  Future<RepositoryResult<T>> refresh() {
    return fetch();
  }
}

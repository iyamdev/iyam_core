import 'repository_result.dart';

abstract class BaseRepository<T> {
  Future<RepositoryResult<T>> getData();
}

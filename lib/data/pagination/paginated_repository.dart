import '../repository/repository_result.dart';
import 'pagination_params.dart';
import 'pagination_result.dart';

abstract class PaginatedRepository<T> {
  Future<RepositoryResult<PaginationResult<T>>> fetchPage(
    PaginationParams params,
  );
}

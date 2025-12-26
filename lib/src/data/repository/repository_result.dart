sealed class RepositoryResult<T> {
  const RepositoryResult();
}

class RepoSuccess<T> extends RepositoryResult<T> {
  final T data;
  const RepoSuccess(this.data);
}

class RepoFailure<T> extends RepositoryResult<T> {
  final String message;
  final int? statusCode;

  const RepoFailure({
    required this.message,
    this.statusCode,
  });
}

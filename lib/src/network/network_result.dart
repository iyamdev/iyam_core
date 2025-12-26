sealed class NetworkResult<T> {
  const NetworkResult();
}

class NetworkSuccess<T> extends NetworkResult<T> {
  final T data;
  const NetworkSuccess(this.data);
}

class NetworkFailure<T> extends NetworkResult<T> {
  final String message;
  final int? statusCode;

  const NetworkFailure({
    required this.message,
    this.statusCode,
  });
}

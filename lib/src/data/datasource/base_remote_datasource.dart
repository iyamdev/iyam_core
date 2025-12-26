import '../../network/api_client.dart';
import '../../network/network_result.dart';
import '../repository/repository_result.dart';

abstract class BaseRemoteDataSource {
  final ApiClient apiClient;

  BaseRemoteDataSource(this.apiClient);

  Future<RepositoryResult<T>> request<T>({
    required Future<NetworkResult> Function() call,
    required T Function(dynamic json) mapper,
  }) async {
    final result = await call();

    if (result is NetworkSuccess) {
      return RepoSuccess(
        mapper(result.data),
      );
    }

    final failure = result as NetworkFailure;
    return RepoFailure(
      message: failure.message,
      statusCode: failure.statusCode,
    );
  }
}

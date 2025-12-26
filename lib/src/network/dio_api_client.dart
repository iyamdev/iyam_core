import 'package:dio/dio.dart';
import 'api_client.dart';
import 'network_result.dart';

class DioApiClient implements ApiClient {
  final Dio dio;

  DioApiClient(this.dio);

  @override
  Future<NetworkResult<T>> get<T>(
    String path, {
    Map<String, dynamic>? query,
  }) async {
    try {
      final response = await dio.get(path, queryParameters: query);
      return NetworkSuccess(response.data as T);
    } on DioException catch (e) {
      return NetworkFailure(
        message: e.message ?? 'Network error',
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<NetworkResult<T>> post<T>(
    String path, {
    dynamic body,
  }) async {
    try {
      final response = await dio.post(path, data: body);
      return NetworkSuccess(response.data as T);
    } on DioException catch (e) {
      return NetworkFailure(
        message: e.message ?? 'Network error',
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<NetworkResult<T>> put<T>(
    String path, {
    dynamic body,
  }) async {
    try {
      final response = await dio.put(path, data: body);
      return NetworkSuccess(response.data as T);
    } on DioException catch (e) {
      return NetworkFailure(
        message: e.message ?? 'Network error',
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<NetworkResult<T>> delete<T>(String path) async {
    try {
      final response = await dio.delete(path);
      return NetworkSuccess(response.data as T);
    } on DioException catch (e) {
      return NetworkFailure(
        message: e.message ?? 'Network error',
        statusCode: e.response?.statusCode,
      );
    }
  }
}

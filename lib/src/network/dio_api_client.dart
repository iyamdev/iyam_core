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
      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        return NetworkSuccess(response.data as T);
      } else {
        return NetworkFailure(
          message: response.statusMessage ?? 'Network error',
          statusCode: response.statusCode,
          data: response.data as T?,
        );
      }
    } on DioException catch (e) {
      return NetworkFailure(
        message: e.message ?? 'Network error',
        statusCode: e.response?.statusCode,
        data: e.response?.data as T?,
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
      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        return NetworkSuccess(response.data as T);
      } else {
        return NetworkFailure(
          message: response.statusMessage ?? 'Network error',
          statusCode: response.statusCode,
          data: response.data as T?,
        );
      }
    } on DioException catch (e) {
      return NetworkFailure(
        message: e.message ?? 'Network error',
        statusCode: e.response?.statusCode,
        data: e.response?.data as T?,
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
      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        return NetworkSuccess(response.data as T);
      } else {
        return NetworkFailure(
          message: response.statusMessage ?? 'Network error',
          statusCode: response.statusCode,
          data: response.data as T?,
        );
      }
    } on DioException catch (e) {
      return NetworkFailure(
        message: e.message ?? 'Network error',
        statusCode: e.response?.statusCode,
        data: e.response?.data as T?,
      );
    }
  }

  @override
  Future<NetworkResult<T>> delete<T>(String path) async {
    try {
      final response = await dio.delete(path);
      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        return NetworkSuccess(response.data as T);
      } else {
        return NetworkFailure(
          message: response.statusMessage ?? 'Network error',
          statusCode: response.statusCode,
          data: response.data as T?,
        );
      }
    } on DioException catch (e) {
      return NetworkFailure(
        message: e.message ?? 'Network error',
        statusCode: e.response?.statusCode,
        data: e.response?.data as T?,
      );
    }
  }
}

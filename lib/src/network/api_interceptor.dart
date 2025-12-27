import 'package:dio/dio.dart';
import 'package:iyam_core/iyam_core.dart';

class ApiInterceptor extends Interceptor {
  final AuthTokenManager tokenManager;
  final LocalStorage localStorage;

  ApiInterceptor(this.tokenManager, this.localStorage);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await tokenManager.accessToken;
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode != 401) {
      await tokenManager.clear();
      await localStorage.clear();
      return handler.next(err);
    }

    return handler.next(err);
  }
}

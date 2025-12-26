import 'package:dio/dio.dart';

import 'auth_token_manager.dart';

class ApiInterceptor extends Interceptor {
  final AuthTokenManager tokenManager;

  ApiInterceptor(this.tokenManager);

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
}

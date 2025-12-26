import 'dart:async';
import 'package:dio/dio.dart';
import 'auth_token_manager.dart';

class RefreshTokenInterceptor extends Interceptor {
  final Dio dio;
  final AuthTokenManager tokenManager;

  bool _isRefreshing = false;
  final List<Completer<Response>> _queue = [];

  RefreshTokenInterceptor({
    required this.dio,
    required this.tokenManager,
  });

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode != 401) {
      return handler.next(err);
    }

    final requestOptions = err.requestOptions;
    final completer = Completer<Response>();
    _queue.add(completer);

    if (_isRefreshing) {
      return handler.resolve(await completer.future);
    }

    _isRefreshing = true;

    try {
      final refreshToken = await tokenManager.refreshToken;
      if (refreshToken == null) {
        throw Exception('No refresh token');
      }

      final response = await dio.post(
        '/auth/refresh',
        data: {'refresh_token': refreshToken},
      );

      final newAccessToken = response.data['access_token'];
      final newRefreshToken = response.data['refresh_token'];

      await tokenManager.save(
        accessToken: newAccessToken,
        refreshToken: newRefreshToken,
      );

      // retry semua request di queue
      for (final c in _queue) {
        final retryResponse = await _retry(requestOptions, newAccessToken);
        c.complete(retryResponse);
      }
    } catch (e) {
      for (final c in _queue) {
        c.completeError(e);
      }
      await tokenManager.clear();
    } finally {
      _queue.clear();
      _isRefreshing = false;
    }

    return handler.resolve(await completer.future);
  }

  Future<Response> _retry(
    RequestOptions request,
    String token,
  ) {
    final options = Options(
      method: request.method,
      headers: {
        ...request.headers,
        'Authorization': 'Bearer $token',
      },
    );

    return dio.request(
      request.path,
      data: request.data,
      queryParameters: request.queryParameters,
      options: options,
    );
  }
}

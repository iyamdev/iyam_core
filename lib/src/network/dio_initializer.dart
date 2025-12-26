import 'package:dio/dio.dart';

import '../storage/secure_storage.dart';
import 'api_interceptor.dart';
import 'refresh_token_interceptor.dart';
import 'auth_token_manager.dart';
import 'logging/api_logging_interceptor.dart';
import '../utils/logger.dart';

class DioInitializer {
  DioInitializer._();

  /// Create Dio instance with standard configuration
  static Dio create({
    required String baseUrl,
    Duration connectTimeout = const Duration(seconds: 10),
    Duration receiveTimeout = const Duration(seconds: 10),
    bool enableLogging = false,
  }) {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: connectTimeout,
        receiveTimeout: receiveTimeout,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    final secureStorage = SecureStorage();
    final tokenManager = AuthTokenManager(secureStorage);

    // ==============================
    // INTERCEPTORS ORDER (IMPORTANT)
    // ==============================

    // 1️⃣ Logging (request pertama)
    if (enableLogging && AppLogger.enabled) {
      dio.interceptors.add(
        ApiLoggingInterceptor(
          logRequest: true,
          logResponse: true,
          logError: true,
        ),
      );
    }

    // 2️⃣ Authorization header
    dio.interceptors.add(
      ApiInterceptor(tokenManager),
    );

    // 3️⃣ Refresh token handler
    dio.interceptors.add(
      RefreshTokenInterceptor(
        dio: dio,
        tokenManager: tokenManager,
      ),
    );

    return dio;
  }
}

import 'dart:convert';
import 'package:dio/dio.dart';
import '../../utils/logger.dart';

class ApiLoggingInterceptor extends Interceptor {
  final bool logRequest;
  final bool logResponse;
  final bool logError;

  ApiLoggingInterceptor({
    this.logRequest = true,
    this.logResponse = true,
    this.logError = true,
  });

  static const _sensitiveKeys = [
    'authorization',
    'password',
    'token',
    'refresh_token',
  ];

  // ==============================
  // REQUEST
  // ==============================

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    if (logRequest) {
      AppLogger.d(
        _formatRequest(options),
        tag: 'API REQUEST',
      );
    }
    handler.next(options);
  }

  // ==============================
  // RESPONSE
  // ==============================

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    if (logResponse) {
      AppLogger.i(
        _formatResponse(response),
        tag: 'API RESPONSE',
      );
    }
    handler.next(response);
  }

  // ==============================
  // ERROR
  // ==============================

  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) {
    if (logError) {
      AppLogger.e(
        _formatError(err),
        tag: 'API ERROR',
        error: err,
        stackTrace: err.stackTrace,
      );
    }
    handler.next(err);
  }

  // ==============================
  // FORMATTERS
  // ==============================

  String _formatRequest(RequestOptions options) {
    final buffer = StringBuffer()
      ..writeln('➡️ ${options.method} ${options.uri}')
      ..writeln('Headers:')
      ..writeln(_prettyJson(
        _sanitizeMap(options.headers),
      ));

    if (options.queryParameters.isNotEmpty) {
      buffer
        ..writeln('Query:')
        ..writeln(
          _prettyJson(
            _sanitizeMap(options.queryParameters),
          ),
        );
    }

    if (options.data != null) {
      buffer
        ..writeln('Body:')
        ..writeln(
          _prettyJson(
            _sanitize(options.data),
          ),
        );
    }

    return buffer.toString();
  }

  String _formatResponse(Response response) {
    return '''
⬅️ ${response.statusCode} ${response.requestOptions.uri}
Response:
${_prettyJson(_sanitize(response.data))}
''';
  }

  String _formatError(DioException err) {
    return '''
❌ ERROR ${err.response?.statusCode ?? ''}
${err.requestOptions.method} ${err.requestOptions.uri}

Message:
${err.message}

Response:
${_prettyJson(_sanitize(err.response?.data))}
''';
  }

  // ==============================
  // HELPERS
  // ==============================

  dynamic _sanitize(dynamic data) {
    if (data is Map) {
      return _sanitizeMap(data);
    }
    if (data is List) {
      return data.map(_sanitize).toList();
    }
    return data;
  }

  Map<String, dynamic> _sanitizeMap(
    Map<dynamic, dynamic> map,
  ) {
    final result = <String, dynamic>{};

    map.forEach((key, value) {
      final k = key.toString().toLowerCase();
      if (_sensitiveKeys.contains(k)) {
        result[key.toString()] = '***';
      } else {
        result[key.toString()] = _sanitize(value);
      }
    });

    return result;
  }

  String _prettyJson(dynamic data) {
    try {
      const encoder = JsonEncoder.withIndent('  ');
      return encoder.convert(data);
    } catch (_) {
      return data.toString();
    }
  }
}

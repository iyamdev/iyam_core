import 'dart:developer' as developer;

/// Log level enum
enum LogLevel {
  debug,
  info,
  warning,
  error,
}

/// Global logger untuk iyam_core
class AppLogger {
  AppLogger._();

  /// Toggle global logging
  static bool enabled = true;

  /// Minimum log level yang akan dicetak
  static LogLevel minLevel = LogLevel.debug;

  // ==============================
  // PUBLIC SHORTCUTS
  // ==============================

  static void d(
    String message, {
    Object? data,
    String tag = 'DEBUG',
  }) {
    _log(
      level: LogLevel.debug,
      message: message,
      data: data,
      tag: tag,
    );
  }

  static void i(
    String message, {
    Object? data,
    String tag = 'INFO',
  }) {
    _log(
      level: LogLevel.info,
      message: message,
      data: data,
      tag: tag,
    );
  }

  static void w(
    String message, {
    Object? data,
    String tag = 'WARNING',
  }) {
    _log(
      level: LogLevel.warning,
      message: message,
      data: data,
      tag: tag,
    );
  }

  static void e(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    String tag = 'ERROR',
  }) {
    _log(
      level: LogLevel.error,
      message: message,
      data: error,
      stackTrace: stackTrace,
      tag: tag,
    );
  }

  // ==============================
  // CORE LOGGER
  // ==============================

  static void _log({
    required LogLevel level,
    required String message,
    Object? data,
    StackTrace? stackTrace,
    required String tag,
  }) {
    if (!enabled) return;
    if (level.index < minLevel.index) return;

    final time = DateTime.now().toIso8601String();
    final levelLabel = level.name.toUpperCase();

    final buffer = StringBuffer()
      ..writeln('[$time] [$levelLabel] [$tag]')
      ..writeln(message);

    if (data != null) {
      buffer.writeln('DATA: $data');
    }

    if (stackTrace != null) {
      buffer.writeln('STACKTRACE:');
      buffer.writeln(stackTrace);
    }

    developer.log(
      buffer.toString(),
      name: 'log_developer',
      level: _mapLevel(level),
      error: data is Exception ? data : null,
      stackTrace: stackTrace,
    );
  }

  static int _mapLevel(LogLevel level) {
    switch (level) {
      case LogLevel.debug:
        return 500;
      case LogLevel.info:
        return 800;
      case LogLevel.warning:
        return 900;
      case LogLevel.error:
        return 1000;
    }
  }
}

import 'environment.dart';

class AppConfig {
  final Environment environment;
  final String apiBaseUrl;
  final bool enableLogging;

  const AppConfig._({
    required this.environment,
    required this.apiBaseUrl,
    required this.enableLogging,
  });

  // ==============================
  // FACTORY PRESETS
  // ==============================

  factory AppConfig.development() {
    return const AppConfig._(
      environment: Environment.development,
      apiBaseUrl: 'https://api-dev.example.com',
      enableLogging: true,
    );
  }

  factory AppConfig.staging() {
    return const AppConfig._(
      environment: Environment.staging,
      apiBaseUrl: 'https://api-staging.example.com',
      enableLogging: true,
    );
  }

  factory AppConfig.production() {
    return const AppConfig._(
      environment: Environment.production,
      apiBaseUrl: 'https://api.example.com',
      enableLogging: false,
    );
  }

  // ==============================
  // RUNTIME INSTANCE
  // ==============================

  static late AppConfig _instance;

  static AppConfig get instance => _instance;

  static void initialize(AppConfig config) {
    _instance = config;
  }
}

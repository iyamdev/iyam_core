enum Environment {
  development,
  staging,
  production,
}

extension EnvironmentX on Environment {
  bool get isDev => this == Environment.development;
  bool get isStaging => this == Environment.staging;
  bool get isProd => this == Environment.production;

  String get name {
    switch (this) {
      case Environment.development:
        return 'development';
      case Environment.staging:
        return 'staging';
      case Environment.production:
        return 'production';
    }
  }
}

enum AppLevelEnum {
  development,
  staging,
  production;

  static AppLevelEnum fromString(String value) {
    switch (value.toLowerCase()) {
      case 'production':
      case 'prod':
        return AppLevelEnum.production;
      case 'staging':
      case 'stg':
        return AppLevelEnum.staging;
      case 'development':
      case 'dev':
      default:
        return AppLevelEnum.development;
    }
  }
}

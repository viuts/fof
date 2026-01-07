class EnvironmentConfig {
  static const String env = String.fromEnvironment(
    'ENV',
    defaultValue: 'local',
  );

  static String get apiUrl {
    switch (env) {
      case 'prod':
        return 'https://fof-backend-urjmlwf4ka-uc.a.run.app';
      case 'dev':
        return 'https://fof-backend-urjmlwf4ka-uc.a.run.app';
      case 'local':
      default:
        return 'http://localhost:8080';
    }
  }

  static String get storageBucket {
    switch (env) {
      case 'prod':
        return 'prod-fof.firebasestorage.app';
      case 'dev':
        return 'dev-fof.firebasestorage.app';
      case 'local':
      default:
        return 'dev-fof.firebasestorage.app';
    }
  }
}

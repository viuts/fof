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
        return 'https://fof-backend-urjmlwf4ka-uc.a.run.app'; // Assuming dev uses the same for now, or update if different
      case 'local':
      default:
        // Use 10.0.2.2 for Android emulator to access host localhost
        // Use localhost for iOS simulator
        return 'http://localhost:8080';
    }
  }
}

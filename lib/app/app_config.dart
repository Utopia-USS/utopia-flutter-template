class AppConfig {
  const AppConfig._();

  static const dev = AppConfig._();

  static const all = {'dev': dev};

  static const _currentName = String.fromEnvironment('CONFIG', defaultValue: 'dev');

  static final AppConfig current = all[_currentName]!;
}

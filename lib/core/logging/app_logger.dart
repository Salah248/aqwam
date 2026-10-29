abstract interface class AppLogger {
  void debug(String message);
  void warning(String message, [Object? error]);
  void error(String message, Object error, StackTrace stackTrace);
}

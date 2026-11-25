// Purpose: define the application logging abstraction.
/// Never pass personal data (coordinates, city names) in messages.
abstract interface class AppLogger {
  void debug(String message);
  void info(String message);
  void warning(String message);
  void error(String message, {Object? error, StackTrace? stackTrace});
}

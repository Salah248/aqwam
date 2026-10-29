import 'app_logger.dart';

final class DebugAppLogger implements AppLogger {
  const DebugAppLogger();

  @override
  void debug(String message) {}

  @override
  void error(String message, Object error, StackTrace stackTrace) {}

  @override
  void warning(String message, [Object? error]) {}
}

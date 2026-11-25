import 'package:aqwam/core/logging/app_logger.dart';

final class FakeAppLogger implements AppLogger {
  final errors = <String>[];

  @override
  void debug(String message) {}

  @override
  void info(String message) {}

  @override
  void warning(String message) {}

  @override
  void error(String message, {Object? error, StackTrace? stackTrace}) {
    errors.add(message);
  }
}

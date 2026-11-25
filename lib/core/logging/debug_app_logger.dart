import 'dart:developer';

import 'package:aqwam/core/logging/app_logger.dart';
import 'package:flutter/foundation.dart';

final class DebugAppLogger implements AppLogger {
  @override
  void debug(String message) {
    _log(message, 500);
  }

  @override
  void error(String message, {Object? error, StackTrace? stackTrace}) {
    _log(message, 1000, error: error, stackTrace: stackTrace);
  }

  @override
  void info(String message) {
    _log(message, 800);
  }

  @override
  void warning(String message) {
    _log(message, 900);
  }
}

void _log(String message, int level, {Object? error, StackTrace? stackTrace}) {
  if (!kDebugMode) {
    return;
  }
  log(
    message,
    name: 'aqwam',
    error: error,
    level: level,
    stackTrace: stackTrace,
  );
}

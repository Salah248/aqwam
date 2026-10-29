import 'package:flutter_test/flutter_test.dart';

import 'package:aqwam/core/app_config.dart';
import 'package:aqwam/core/errors/result.dart';
import 'package:aqwam/core/logging/debug_app_logger.dart';
import 'package:aqwam/core/theme/aqwam_tokens.dart';

void main() {
  test('should expose the configured app identity', () {
    expect(AppConfig.appName, 'أقوَم');
    expect(AppConfig.packageId, 'io.github.salah248.aqwam');
  });

  test('should create every result and failure kind', () {
    expect(const Success<int>(1).value, 1);
    expect(const Err<int>(StorageFailure()).failure.kind, FailureKind.storage);
    expect(const NetworkFailure().kind, FailureKind.network);
    expect(const PermissionFailure().kind, FailureKind.permission);
    expect(const ValidationFailure().kind, FailureKind.validation);
    expect(const NotFoundFailure().kind, FailureKind.notFound);
    expect(const UnexpectedFailure().kind, FailureKind.unexpected);
  });

  test('should copy token values without changing unrelated tokens', () {
    final copy = AqwamTokens.light.copyWith(primary: AqwamTokens.dark.primary);

    expect(copy.primary, AqwamTokens.dark.primary);
    expect(copy.background, AqwamTokens.light.background);
  });

  test('should provide a safe debug logger', () {
    const DebugAppLogger()
      ..debug('debug')
      ..warning('warning')
      ..error('error', Exception(), StackTrace.empty);
  });
}

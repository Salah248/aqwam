import 'package:aqwam/core/errors/failure.dart';
import 'package:aqwam/core/errors/result.dart';
import 'package:aqwam/core/logging/app_logger.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'notification_permission.dart';

final class FlutterLocalNotificationPermission
    implements NotificationPermissionGateway {
  FlutterLocalNotificationPermission({
    required this.appLogger,
    FlutterLocalNotificationsPlugin? plugin,
  }) : _plugin = plugin ?? FlutterLocalNotificationsPlugin();

  final AppLogger appLogger;
  final FlutterLocalNotificationsPlugin _plugin;

  @override
  Future<Result<bool>> request() async {
    try {
      final android = _plugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >();
      final granted = await android?.requestNotificationsPermission();
      return Success(granted ?? false);
    } on Object catch (error, stackTrace) {
      appLogger.error(
        'Failed to request notification permission',
        error: error,
        stackTrace: stackTrace,
      );
      return const Err(PermissionFailure());
    }
  }
}

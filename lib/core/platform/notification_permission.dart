import '../errors/result.dart';

abstract interface class NotificationPermissionGateway {
  Future<Result<bool>> request();
}

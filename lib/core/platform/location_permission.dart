import '../errors/result.dart';

abstract interface class LocationPermissionGateway {
  Future<Result<bool>> request();
}

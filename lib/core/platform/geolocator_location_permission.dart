import 'package:aqwam/core/errors/failure.dart';
import 'package:aqwam/core/errors/result.dart';
import 'package:aqwam/core/logging/app_logger.dart';
import 'package:geolocator/geolocator.dart' as geolocator;

import 'location_permission.dart';

final class GeolocatorLocationPermission implements LocationPermissionGateway {
  const GeolocatorLocationPermission({required this.appLogger});

  final AppLogger appLogger;

  @override
  Future<Result<bool>> request() async {
    try {
      final permission = await geolocator.Geolocator.requestPermission();
      return Success(
        permission == geolocator.LocationPermission.always ||
            permission == geolocator.LocationPermission.whileInUse,
      );
    } on Object catch (error, stackTrace) {
      appLogger.error(
        'Failed to request location permission',
        error: error,
        stackTrace: stackTrace,
      );
      return const Err(PermissionFailure());
    }
  }
}

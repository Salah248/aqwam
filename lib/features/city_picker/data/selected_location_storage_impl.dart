import 'dart:convert';

import 'package:aqwam/core/logging/app_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/errors/failure.dart';
import '../../../core/errors/result.dart';
import '../domain/entities/selected_location.dart';
import '../domain/repositories/selected_location_storage.dart';

class SelectedLocationStorageImpl implements SelectedLocationStorage {
  SelectedLocationStorageImpl({required this._appLogger});
  static const storageKey = 'selected_location';
  final AppLogger _appLogger;
  @override
  Future<Result<SelectedLocation?>> read() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(storageKey);
      if (raw == null) return const Success(null);
      return Success(SelectedLocation.tryFromJson(jsonDecode(raw)));
    } on FormatException {
      _appLogger.warning('Saved location is corrupted, ignoring it');
      return const Success(null);
    } on Object catch (e, st) {
      _appLogger.error(
        'Failed to read selected location',
        error: e,
        stackTrace: st,
      );
      return const Err(StorageFailure());
    }
  }

  @override
  Future<Result<void>> save(SelectedLocation location) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = jsonEncode(location.toJson());
      final success = await prefs.setString(storageKey, raw);
      if (!success) {
        _appLogger.error('Failed to save selected location');
        return const Err(StorageFailure());
      }
      return const Success(null);
    } on Object catch (e, st) {
      _appLogger.error(
        'Failed to save selected location',
        error: e,
        stackTrace: st,
      );
      return const Err(StorageFailure());
    }
  }
}

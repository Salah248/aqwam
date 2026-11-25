import 'package:aqwam/core/errors/result.dart';
import 'package:aqwam/core/logging/app_logger.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../../../core/errors/failure.dart';
import '../domain/entities/location_entities.dart';
import '../domain/repositories/locations_repository.dart';
import 'locations_parser.dart';

class LocationsRepositoryImpl implements LocationsRepository {
  LocationsRepositoryImpl({required this._appLogger, AssetBundle? bundle})
    : _bundle = bundle ?? rootBundle;

  static const _assetPath = 'assets/data/locations.json';

  final AssetBundle _bundle;
  List<Country>? _cache;
  final AppLogger _appLogger;

  @override
  Future<Result<List<Country>>> getCountries() async {
    final cached = _cache;
    if (cached != null) return Success(cached);
    try {
      final countries = await _load();
      _cache = countries; // نحفظ بعد النجاح بس
      return Success(countries);
    } on Object catch (e, st) {
      _appLogger.error(
        'Failed to load locations asset',
        error: e,
        stackTrace: st,
      );
      return const Err(StorageFailure());
    }
  }

  Future<List<Country>> _load() async {
    final raw = await _bundle.loadString(_assetPath);

    return compute(parseCountries, raw);
  }
}

import 'package:aqwam/core/errors/result.dart';
import 'package:aqwam/core/logging/app_logger.dart';
import 'package:aqwam/features/settings/data/datasources/settings_local_datasource.dart';
import 'package:aqwam/features/settings/domain/entities/app_settings.dart';
import 'package:aqwam/features/settings/domain/repositories/settings_repository.dart';

final class SettingsRepositoryImpl implements SettingsRepository {
  const SettingsRepositoryImpl(this._datasource, this._logger);

  final SettingsLocalDatasource _datasource;
  final AppLogger _logger;

  @override
  Future<Result<AppSettings>> load() async {
    try {
      return Success(await _datasource.read() ?? const AppSettings.defaults());
    } on Object catch (error, stackTrace) {
      _logger.error('Unable to load settings', error, stackTrace);
      return const Err(StorageFailure());
    }
  }

  @override
  Future<Result<void>> save(AppSettings settings) async {
    try {
      await _datasource.write(settings);
      return const Success(null);
    } on Object catch (error, stackTrace) {
      _logger.error('Unable to save settings', error, stackTrace);
      return const Err(StorageFailure());
    }
  }
}

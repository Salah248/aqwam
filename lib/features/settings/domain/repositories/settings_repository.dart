import 'package:aqwam/core/errors/result.dart';
import 'package:aqwam/features/settings/domain/entities/app_settings.dart';

abstract interface class SettingsRepository {
  Future<Result<AppSettings>> load();
  Future<Result<void>> save(AppSettings settings);
}

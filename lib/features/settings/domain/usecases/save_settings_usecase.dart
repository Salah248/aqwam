import 'package:aqwam/core/errors/result.dart';
import 'package:aqwam/features/settings/domain/entities/app_settings.dart';
import 'package:aqwam/features/settings/domain/repositories/settings_repository.dart';

final class SaveSettingsUsecase {
  const SaveSettingsUsecase(this._repository);

  final SettingsRepository _repository;

  Future<Result<void>> call(AppSettings settings) => _repository.save(settings);
}

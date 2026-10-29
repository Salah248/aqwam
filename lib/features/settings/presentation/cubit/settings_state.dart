import 'package:aqwam/features/settings/domain/entities/app_settings.dart';

sealed class SettingsState {
  const SettingsState();
}

final class SettingsLoading extends SettingsState {
  const SettingsLoading();
}

final class SettingsReady extends SettingsState {
  const SettingsReady(this.settings);

  final AppSettings settings;
}

final class SettingsError extends SettingsState {
  const SettingsError();
}

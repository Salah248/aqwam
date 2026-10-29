import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:aqwam/core/errors/result.dart';
import 'package:aqwam/core/utils/number_formatter.dart';
import 'package:aqwam/features/settings/domain/entities/app_settings.dart';
import 'package:aqwam/features/settings/domain/usecases/load_settings_usecase.dart';
import 'package:aqwam/features/settings/domain/usecases/save_settings_usecase.dart';
import 'settings_state.dart';

final class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(this._load, this._save) : super(const SettingsLoading());

  final LoadSettingsUsecase _load;
  final SaveSettingsUsecase _save;

  Future<void> load() async {
    final result = await _load();
    if (isClosed) {
      return;
    }
    switch (result) {
      case Success(:final value):
        emit(SettingsReady(value));
      case Err():
        emit(const SettingsError());
    }
  }

  Future<void> setThemeMode(ThemeMode mode) => _update(
    (settings) => settings.copyWith(themeMode: mode),
  );

  Future<void> setLocale(Locale locale) => _update(
    (settings) => settings.copyWith(locale: locale),
  );

  Future<void> setDigitStyle(DigitStyle style) => _update(
    (settings) => settings.copyWith(digitStyle: style),
  );

  Future<void> _update(AppSettings Function(AppSettings) update) async {
    final current = state;
    if (current is! SettingsReady) {
      return;
    }
    final settings = update(current.settings);
    final result = await _save(settings);
    if (isClosed) {
      return;
    }
    if (result is Success<void>) {
      emit(SettingsReady(settings));
    }
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:aqwam/core/platform/key_value_store.dart';
import 'package:aqwam/core/utils/number_formatter.dart';
import 'package:aqwam/features/settings/domain/entities/app_settings.dart';

final class SettingsLocalDatasource {
  const SettingsLocalDatasource(this._store);

  static const key = 'app_settings';
  final KeyValueStore _store;

  Future<AppSettings?> read() async {
    final value = await _store.read(key);
    if (value == null) {
      return null;
    }
    final json = jsonDecode(value) as Map<String, dynamic>;
    return AppSettings(
      themeMode: _themeModeFromName(json['theme'] as String),
      locale: Locale(json['locale'] as String),
      digitStyle: _digitStyleFromName(json['digits'] as String),
    );
  }

  Future<void> write(AppSettings settings) async {
    await _store.write(
      key,
      jsonEncode({
        'theme': settings.themeMode.name,
        'locale': settings.locale.languageCode,
        'digits': settings.digitStyle.name,
      }),
    );
  }
}

ThemeMode _themeModeFromName(String value) => ThemeMode.values.firstWhere(
  (mode) => mode.name == value,
  orElse: () => ThemeMode.light,
);

DigitStyle _digitStyleFromName(String value) => DigitStyle.values.firstWhere(
  (style) => style.name == value,
  orElse: () => DigitStyle.arabicIndic,
);

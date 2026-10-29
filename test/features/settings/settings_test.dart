import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:aqwam/core/errors/result.dart';
import 'package:aqwam/core/logging/app_logger.dart';
import 'package:aqwam/core/platform/key_value_store.dart';
import 'package:aqwam/core/utils/number_formatter.dart';
import 'package:aqwam/features/settings/data/datasources/settings_local_datasource.dart';
import 'package:aqwam/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:aqwam/features/settings/domain/entities/app_settings.dart';
import 'package:aqwam/features/settings/domain/repositories/settings_repository.dart';
import 'package:aqwam/features/settings/domain/usecases/load_settings_usecase.dart';
import 'package:aqwam/features/settings/domain/usecases/save_settings_usecase.dart';
import 'package:aqwam/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:aqwam/features/settings/presentation/cubit/settings_state.dart';

void main() {
  group('SettingsRepositoryImpl', () {
    test('should return defaults when storage is empty', () async {
      final repository = SettingsRepositoryImpl(
        SettingsLocalDatasource(FakeStore()),
        const NoopLogger(),
      );

      final result = await repository.load();

      expect(result, isA<Success<AppSettings>>());
      expect(
        (result as Success<AppSettings>).value,
        const AppSettings.defaults(),
      );
    });

    test('should save and load settings through the store', () async {
      final store = FakeStore();
      final repository = SettingsRepositoryImpl(
        SettingsLocalDatasource(store),
        const NoopLogger(),
      );
      const settings = AppSettings(
        themeMode: ThemeMode.dark,
        locale: Locale('en'),
        digitStyle: DigitStyle.western,
      );

      await repository.save(settings);
      final result = await repository.load();

      expect((result as Success<AppSettings>).value, settings);
    });
  });

  test('should delegate loading to the repository use case', () async {
    const repository = FakeRepository();

    expect(
      await const LoadSettingsUsecase(repository)(),
      isA<Success<AppSettings>>(),
    );
  });

  test('should delegate saving to the repository use case', () async {
    const repository = FakeRepository();

    expect(
      await const SaveSettingsUsecase(repository)(
        const AppSettings.defaults(),
      ),
      isA<Success<void>>(),
    );
  });

  blocTest<SettingsCubit, SettingsState>(
    'should emit ready when loading succeeds',
    build: () => SettingsCubit(
      const LoadSettingsUsecase(FakeRepository()),
      const SaveSettingsUsecase(FakeRepository()),
    )..load(),
    expect: () => [isA<SettingsReady>()],
  );

  blocTest<SettingsCubit, SettingsState>(
    'should emit error when loading fails',
    build: () => SettingsCubit(
      const LoadSettingsUsecase(FailingRepository()),
      const SaveSettingsUsecase(FailingRepository()),
    )..load(),
    expect: () => [isA<SettingsError>()],
  );

  blocTest<SettingsCubit, SettingsState>(
    'should emit updated settings when a setting changes',
    build: () => SettingsCubit(
      const LoadSettingsUsecase(FakeRepository()),
      const SaveSettingsUsecase(FakeRepository()),
    )..load(),
    act: (cubit) async {
      await cubit.setThemeMode(ThemeMode.dark);
      await cubit.setLocale(const Locale('en'));
      await cubit.setDigitStyle(DigitStyle.western);
    },
    expect: () => [
      isA<SettingsReady>(),
      isA<SettingsReady>(),
      isA<SettingsReady>(),
    ],
  );
}

final class FakeStore implements KeyValueStore {
  final Map<String, String> values = {};

  @override
  Future<void> delete(String key) async => values.remove(key);

  @override
  Future<String?> read(String key) async => values[key];

  @override
  Future<void> write(String key, String value) async => values[key] = value;
}

final class NoopLogger implements AppLogger {
  const NoopLogger();

  @override
  void debug(String message) {}

  @override
  void error(String message, Object error, StackTrace stackTrace) {}

  @override
  void warning(String message, [Object? error]) {}
}

final class FakeRepository implements SettingsRepository {
  const FakeRepository();

  @override
  Future<Result<AppSettings>> load() async =>
      const Success(AppSettings.defaults());

  @override
  Future<Result<void>> save(AppSettings settings) async => const Success(null);
}

final class FailingRepository implements SettingsRepository {
  const FailingRepository();

  @override
  Future<Result<AppSettings>> load() async => const Err(StorageFailure());

  @override
  Future<Result<void>> save(AppSettings settings) async =>
      const Err(StorageFailure());
}

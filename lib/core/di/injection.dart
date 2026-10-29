import 'package:get_it/get_it.dart';

import 'package:aqwam/core/logging/app_logger.dart';
import 'package:aqwam/core/logging/debug_app_logger.dart';
import 'package:aqwam/core/platform/key_value_store.dart';
import 'package:aqwam/features/settings/data/datasources/settings_local_datasource.dart';
import 'package:aqwam/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:aqwam/features/settings/domain/repositories/settings_repository.dart';
import 'package:aqwam/features/settings/domain/usecases/load_settings_usecase.dart';
import 'package:aqwam/features/settings/domain/usecases/save_settings_usecase.dart';
import 'package:aqwam/features/settings/presentation/cubit/settings_cubit.dart';

final getIt = GetIt.instance;

void configureDependencies() {
  getIt
    ..registerSingleton<AppLogger>(const DebugAppLogger())
    ..registerSingleton<KeyValueStore>(MemoryKeyValueStore())
    ..registerLazySingleton(
      () => SettingsLocalDatasource(getIt<KeyValueStore>()),
    )
    ..registerLazySingleton<SettingsRepository>(
      () => SettingsRepositoryImpl(
        getIt<SettingsLocalDatasource>(),
        getIt<AppLogger>(),
      ),
    )
    ..registerLazySingleton(
      () => LoadSettingsUsecase(getIt<SettingsRepository>()),
    )
    ..registerLazySingleton(
      () => SaveSettingsUsecase(getIt<SettingsRepository>()),
    )
    ..registerFactory(
      () => SettingsCubit(
        getIt<LoadSettingsUsecase>(),
        getIt<SaveSettingsUsecase>(),
      ),
    );
}

final class MemoryKeyValueStore implements KeyValueStore {
  final Map<String, String> _values = {};

  @override
  Future<void> delete(String key) async => _values.remove(key);

  @override
  Future<String?> read(String key) async => _values[key];

  @override
  Future<void> write(String key, String value) async => _values[key] = value;
}

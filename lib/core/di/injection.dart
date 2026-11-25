import 'package:aqwam/core/logging/app_logger.dart';
import 'package:aqwam/core/logging/debug_app_logger.dart';
import 'package:get_it/get_it.dart';
import '../platform/flutter_local_notification_permission.dart';
import '../platform/geolocator_location_permission.dart';
import '../platform/location_permission.dart';
import '../platform/notification_permission.dart';

import '../../features/city_picker/data/locations_repository_impl.dart';
import '../../features/city_picker/data/selected_location_storage_impl.dart';
import '../../features/city_picker/domain/repositories/locations_repository.dart';
import '../../features/city_picker/domain/repositories/selected_location_storage.dart';
import '../../features/city_picker/domain/usecases/get_countries_usecase.dart';
import '../../features/city_picker/domain/usecases/save_selected_location_usecase.dart';
import '../../features/city_picker/presentation/cubit/city_picker_cubit.dart';

final getIt = GetIt.instance;
void setupDependencies() {
  getIt.registerLazySingleton<AppLogger>(DebugAppLogger.new);
  _registerCityPicker(getIt);
  _registerOnboarding(getIt);
}

void _registerOnboarding(GetIt getIt) {
  getIt
    ..registerLazySingleton<LocationPermissionGateway>(
      () => GeolocatorLocationPermission(appLogger: getIt()),
    )
    ..registerLazySingleton<NotificationPermissionGateway>(
      () => FlutterLocalNotificationPermission(appLogger: getIt()),
    );
}

void _registerCityPicker(GetIt getIt) {
  getIt
    ..registerLazySingleton<LocationsRepository>(
      () => LocationsRepositoryImpl(appLogger: getIt()),
    )
    ..registerLazySingleton<SelectedLocationStorage>(
      () => SelectedLocationStorageImpl(appLogger: getIt()),
    )
    ..registerLazySingleton<GetCountriesUsecase>(
      () => GetCountriesUsecase(getIt()),
    )
    ..registerLazySingleton<SaveSelectedLocationUsecase>(
      () => SaveSelectedLocationUsecase(getIt()),
    )
    ..registerFactoryParam<CityPickerCubit, String, void>(
      (languageCode, _) => CityPickerCubit(
        getIt(),
        getIt(),
        languageCode: languageCode,
      ),
    );
}

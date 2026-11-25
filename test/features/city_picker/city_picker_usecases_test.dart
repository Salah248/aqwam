import 'package:aqwam/core/errors/result.dart';
import 'package:aqwam/features/city_picker/domain/entities/location_entities.dart';
import 'package:aqwam/features/city_picker/domain/entities/selected_location.dart';
import 'package:aqwam/features/city_picker/domain/repositories/locations_repository.dart';
import 'package:aqwam/features/city_picker/domain/repositories/selected_location_storage.dart';
import 'package:aqwam/features/city_picker/domain/usecases/get_countries_usecase.dart';
import 'package:aqwam/features/city_picker/domain/usecases/save_selected_location_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _LocationsRepository extends Mock implements LocationsRepository {}

class _SelectedLocationStorage extends Mock
    implements SelectedLocationStorage {}

void main() {
  test('GetCountriesUsecase delegates to the repository', () async {
    final repository = _LocationsRepository();
    const countries = <Country>[];
    when(
      repository.getCountries,
    ).thenAnswer((_) async => const Success(countries));

    final result = await GetCountriesUsecase(repository).call();

    expect(result, const Success<List<Country>>(countries));
    verify(repository.getCountries).called(1);
  });

  test('SaveSelectedLocationUsecase delegates to storage', () async {
    final storage = _SelectedLocationStorage();
    const location = SelectedLocation(
      countryCode: 'XX',
      countryNameAr: 'Fixture',
      countryNameEn: 'Fixture',
      regionId: 'XX.1',
      regionNameAr: 'Fixture',
      regionNameEn: 'Fixture',
      cityId: 1,
      cityNameAr: 'Fixture',
      cityNameEn: 'Fixture',
      latitude: 1,
      longitude: 1,
      timeZone: 'Etc/UTC',
    );
    when(
      () => storage.save(location),
    ).thenAnswer((_) async => const Success(null));

    final result = await SaveSelectedLocationUsecase(storage).call(location);

    expect(result, const Success<void>(null));
    verify(() => storage.save(location)).called(1);
  });
}

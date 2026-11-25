import 'package:aqwam/features/city_picker/domain/entities/location_entities.dart';
import 'package:aqwam/features/city_picker/domain/repositories/locations_repository.dart';
import 'package:aqwam/features/city_picker/presentation/cubit/city_picker_cubit.dart';
import 'package:aqwam/features/city_picker/presentation/cubit/city_picker_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:aqwam/features/city_picker/domain/entities/selected_location.dart';
import 'package:aqwam/features/city_picker/domain/repositories/selected_location_storage.dart';
import 'package:aqwam/features/city_picker/domain/usecases/get_countries_usecase.dart';
import 'package:aqwam/features/city_picker/domain/usecases/save_selected_location_usecase.dart';
import 'package:aqwam/core/errors/failure.dart';
import 'package:aqwam/core/errors/result.dart';

class _MockRepository extends Mock implements LocationsRepository {}

class _MockStorage extends Mock implements SelectedLocationStorage {}

// Test fixtures only. Not real content.
const _a = City(
  id: 1,
  nameAr: 'مدينة أ',
  nameEn: 'City A',
  latitude: 1,
  longitude: 1,
  timeZone: 'Africa/Cairo',
);
const _b = City(
  id: 2,
  nameAr: 'مدينة ب',
  nameEn: 'City B',
  latitude: 2,
  longitude: 2,
  timeZone: 'Africa/Cairo',
);
const _regionOne = Region(
  id: 'XX.1',
  nameAr: 'منطقة ١',
  nameEn: 'Region 1',
  cities: [_a, _b],
);
const _regionTwo = Region(
  id: 'XX.2',
  nameAr: 'منطقة ٢',
  nameEn: 'Region 2',
  cities: [_b],
);
const _multi = Country(
  code: 'XX',
  nameAr: 'دولة س',
  nameEn: 'Country X',
  regionLabelAr: 'المحافظة',
  regionLabelEn: 'Governorate',
  regions: [_regionOne, _regionTwo],
);
const _single = Country(
  code: 'YY',
  nameAr: 'دولة ص',
  nameEn: 'Country Y',
  regionLabelAr: 'المنطقة',
  regionLabelEn: 'Region',
  regions: [_regionOne],
);

void main() {
  late _MockRepository repository;
  late _MockStorage storage;

  setUpAll(() {
    registerFallbackValue(
      SelectedLocation.fromSelection(
        country: _multi,
        region: _regionOne,
        city: _a,
      ),
    );
  });

  setUp(() {
    repository = _MockRepository();
    storage = _MockStorage();
  });

  CityPickerCubit build() => CityPickerCubit(
    GetCountriesUsecase(repository),
    SaveSelectedLocationUsecase(storage),
    languageCode: 'ar',
  );
  const ready = CityPickerState(
    status: CityPickerStatus.ready,
    countries: [_multi, _single],
  );

  group('load', () {
    blocTest<CityPickerCubit, CityPickerState>(
      'emits ready with countries',
      setUp: () => when(
        () => repository.getCountries(),
      ).thenAnswer((_) async => const Success([_multi, _single])),
      build: build,
      act: (cubit) => cubit.load(),
      expect: () => [
        const CityPickerState(),
        ready,
      ],
    );

    blocTest<CityPickerCubit, CityPickerState>(
      'emits failure when the repository throws',
      setUp: () => when(
        () => repository.getCountries(),
      ).thenAnswer((_) async => const Err(StorageFailure())),
      build: build,
      act: (cubit) => cubit.load(),
      expect: () => [
        const CityPickerState(),
        const CityPickerState(
          status: CityPickerStatus.failure,
          failure: StorageFailure(),
        ),
      ],
    );

    blocTest<CityPickerCubit, CityPickerState>(
      'emits empty when the repository returns no countries',
      setUp: () => when(
        () => repository.getCountries(),
      ).thenAnswer((_) async => const Success([])),
      build: build,
      act: (cubit) => cubit.load(),
      expect: () => [
        const CityPickerState(),
        const CityPickerState(status: CityPickerStatus.empty),
      ],
    );

    blocTest<CityPickerCubit, CityPickerState>(
      'retries after failure and loads countries',
      setUp: () {
        var calls = 0;
        when(() => repository.getCountries()).thenAnswer((_) async {
          calls++;
          return calls == 1
              ? const Err(StorageFailure())
              : const Success([_multi, _single]);
        });
      },
      build: build,
      act: (cubit) async {
        await cubit.load();
        await cubit.load();
      },
      expect: () => [
        const CityPickerState(),
        const CityPickerState(
          status: CityPickerStatus.failure,
          failure: StorageFailure(),
        ),
        const CityPickerState(),
        ready,
      ],
    );
  });

  group('selection', () {
    blocTest<CityPickerCubit, CityPickerState>(
      'selecting a country with several regions moves to the region step',
      build: build,
      seed: () => ready,
      act: (cubit) => cubit.selectCountry(_multi),
      verify: (cubit) {
        expect(cubit.state.step, CityPickerStep.region);
        expect(cubit.state.totalSteps, 3);
      },
    );

    blocTest<CityPickerCubit, CityPickerState>(
      'a country with one region skips the region step',
      build: build,
      seed: () => ready,
      act: (cubit) => cubit.selectCountry(_single),
      verify: (cubit) {
        expect(cubit.state.region, _regionOne);
        expect(cubit.state.step, CityPickerStep.city);
        expect(cubit.state.totalSteps, 2);
        expect(cubit.state.stepNumber, 2);
      },
    );

    blocTest<CityPickerCubit, CityPickerState>(
      'selecting a city enables confirmation',
      build: build,
      seed: () => ready,
      act: (cubit) => cubit
        ..selectCountry(_multi)
        ..selectRegion(_regionOne)
        ..selectCity(_a),
      verify: (cubit) {
        expect(cubit.state.canConfirm, isTrue);
        expect(cubit.state.city, _a);
      },
    );
  });

  group('goToStep', () {
    final full = ready.withSelection(
      country: _multi,
      region: _regionOne,
      city: _a,
    );

    blocTest<CityPickerCubit, CityPickerState>(
      'country clears everything',
      build: build,
      seed: () => full,
      act: (cubit) => cubit.goToStep(CityPickerStep.country),
      verify: (cubit) {
        expect(cubit.state.country, isNull);
        expect(cubit.state.region, isNull);
        expect(cubit.state.city, isNull);
      },
    );

    blocTest<CityPickerCubit, CityPickerState>(
      'region keeps the country only',
      build: build,
      seed: () => full,
      act: (cubit) => cubit.goToStep(CityPickerStep.region),
      verify: (cubit) {
        expect(cubit.state.country, _multi);
        expect(cubit.state.region, isNull);
        expect(cubit.state.city, isNull);
      },
    );

    blocTest<CityPickerCubit, CityPickerState>(
      'city keeps country and region',
      build: build,
      seed: () => full,
      act: (cubit) => cubit.goToStep(CityPickerStep.city),
      verify: (cubit) {
        expect(cubit.state.region, _regionOne);
        expect(cubit.state.city, isNull);
      },
    );
  });
  group('confirm', () {
    final full = ready.withSelection(
      country: _multi,
      region: _regionOne,
      city: _a,
    );

    test('saves the selection and returns true', () async {
      when(
        () => storage.save(any()),
      ).thenAnswer((_) async => const Success(null));
      final cubit = build()..emit(full);

      expect(await cubit.confirm(), const Success<void>(null));
      verify(
        () => storage.save(
          SelectedLocation.fromSelection(
            country: _multi,
            region: _regionOne,
            city: _a,
          ),
        ),
      ).called(1);
    });

    test('returns false when saving fails', () async {
      when(
        () => storage.save(any()),
      ).thenAnswer((_) async => const Err(StorageFailure()));
      final cubit = build()..emit(full);

      expect(await cubit.confirm(), const Err<void>(StorageFailure()));
    });

    test('returns false and saves nothing without a city', () async {
      final cubit = build()..emit(ready);

      expect(await cubit.confirm(), const Err<void>(UnexpectedFailure()));
      verifyNever(() => storage.save(any()));
    });
  });
  group('search', () {
    test('filters the visible list and a selection resets the query', () {
      final cubit = build()
        ..emit(ready)
        ..search('دولة ص');
      expect(cubit.state.visibleCountries, [_single]);

      cubit.selectCountry(_multi);
      expect(cubit.state.query, isEmpty);
    });
  });
}

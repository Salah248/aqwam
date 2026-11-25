import 'package:aqwam/core/l10n/app_localizations.dart';
import 'package:aqwam/core/theme/app_theme.dart';
import 'package:aqwam/core/utils/number_formatter.dart';
import 'package:aqwam/features/city_picker/domain/entities/location_entities.dart';
import 'package:aqwam/features/city_picker/domain/entities/selected_location.dart';
import 'package:aqwam/features/city_picker/domain/repositories/locations_repository.dart';
import 'package:aqwam/features/city_picker/domain/repositories/selected_location_storage.dart';
import 'package:aqwam/features/city_picker/domain/usecases/get_countries_usecase.dart';
import 'package:aqwam/features/city_picker/domain/usecases/save_selected_location_usecase.dart';
import 'package:aqwam/core/errors/failure.dart';
import 'package:aqwam/core/errors/result.dart';
import 'package:aqwam/features/city_picker/presentation/cubit/city_picker_cubit.dart';
import 'package:aqwam/features/city_picker/presentation/pages/city_picker_page.dart';
import 'package:aqwam/features/city_picker/presentation/widgets/city_picker_chip.dart';
import 'package:aqwam/features/city_picker/presentation/widgets/city_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

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

class _FakeRepository implements LocationsRepository {
  @override
  Future<Result<List<Country>>> getCountries() async =>
      const Success([_multi, _single]);
}

class _RetryRepository implements LocationsRepository {
  int calls = 0;

  @override
  Future<Result<List<Country>>> getCountries() async {
    calls++;
    if (calls == 1) return const Err(StorageFailure());
    return const Success([_multi, _single]);
  }
}

class _FakeStorage implements SelectedLocationStorage {
  final saved = <SelectedLocation>[];

  @override
  Future<Result<SelectedLocation?>> read() async =>
      Success(saved.isEmpty ? null : saved.last);

  @override
  Future<Result<void>> save(SelectedLocation location) async {
    saved.add(location);
    return const Success(null);
  }
}

/// Opens the picker from a home page, the way onboarding does,
/// and records what the picker returns.
Future<void> _openPicker(
  WidgetTester tester,
  _FakeStorage storage,
  List<bool?> results, {
  LocationsRepository? repository,
}) async {
  tester.view
    ..physicalSize = const Size(1080, 2400)
    ..devicePixelRatio = 3;
  addTearDown(tester.view.reset);

  final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => Scaffold(
          body: Center(
            child: TextButton(
              onPressed: () async =>
                  results.add(await context.push<bool>('/picker')),
              child: const Text('open'),
            ),
          ),
        ),
      ),
      GoRoute(
        path: '/picker',
        builder: (context, state) => BlocProvider(
          create: (_) => CityPickerCubit(
            GetCountriesUsecase(repository ?? _FakeRepository()),
            SaveSelectedLocationUsecase(storage),
            languageCode: 'ar',
          )..load(),
          child: const CityPickerView(),
        ),
      ),
    ],
  );

  await tester.pumpWidget(
    ScreenUtilInit(
      designSize: const Size(360, 800),
      builder: (context, child) => MaterialApp.router(
        theme: buildLightTheme(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale('ar'),
        routerConfig: router,
      ),
    ),
  );
  await tester.pumpAndSettle();
  await tester.tap(find.text('open'));
  await tester.pumpAndSettle();
}

Finder _tile(String label) => find.widgetWithText(CityTile, label);

void main() {
  testWidgets('renders Arabic-Indic digits in the step label', (tester) async {
    await _openPicker(tester, _FakeStorage(), []);

    final localizations = AppLocalizations.of(
      tester.element(find.byType(CityPickerView)),
    );
    final stepLabel = localizations.cityPickerStepLabel(
      formatInt(1, languageCode: 'ar'),
      formatInt(3, languageCode: 'ar'),
      localizations.cityPickerCountry,
    );

    expect(stepLabel, contains('١'));
    expect(stepLabel, contains('٣'));
    expect(find.text(stepLabel), findsOneWidget);
  });

  testWidgets('shows load error and retries successfully', (tester) async {
    final repository = _RetryRepository();
    await _openPicker(
      tester,
      _FakeStorage(),
      [],
      repository: repository,
    );

    final localizations = AppLocalizations.of(
      tester.element(find.byType(CityPickerView)),
    );
    expect(find.text(localizations.cityPickerStorageError), findsOneWidget);
    expect(find.text(localizations.cityPickerRetry), findsOneWidget);

    await tester.tap(find.text(localizations.cityPickerRetry));
    await tester.pumpAndSettle();

    expect(repository.calls, 2);
    expect(find.byType(CityTile), findsNWidgets(2));
  });

  testWidgets('shows no-results text when search has no match', (tester) async {
    await _openPicker(tester, _FakeStorage(), []);

    final localizations = AppLocalizations.of(
      tester.element(find.byType(CityPickerView)),
    );
    await tester.enterText(find.byType(TextField), 'no-such-location');
    await tester.pumpAndSettle();

    expect(find.text(localizations.cityPickerNoResults), findsOneWidget);
  });

  testWidgets('shows the next level after each selection, then saves', (
    tester,
  ) async {
    final storage = _FakeStorage();
    final results = <bool?>[];
    await _openPicker(tester, storage, results);

    expect(_tile('دولة س'), findsOneWidget);
    expect(_tile('دولة ص'), findsOneWidget);

    await tester.tap(_tile('دولة س'));
    await tester.pumpAndSettle();
    expect(_tile('منطقة ١'), findsOneWidget);
    expect(_tile('منطقة ٢'), findsOneWidget);

    await tester.tap(_tile('منطقة ١'));
    await tester.pumpAndSettle();
    expect(_tile('مدينة أ'), findsOneWidget);
    expect(_tile('مدينة ب'), findsOneWidget);
    expect(find.text('تأكيد الموقع'), findsNothing);

    await tester.tap(_tile('مدينة أ'));
    await tester.pumpAndSettle();
    expect(find.text('تأكيد الموقع'), findsOneWidget);

    await tester.tap(find.text('تأكيد الموقع'));
    await tester.pumpAndSettle();

    expect(results, [true]);
    expect(storage.saved.single.cityId, 1);
    expect(storage.saved.single.regionId, 'XX.1');
    expect(storage.saved.single.countryCode, 'XX');
  });

  testWidgets('a country with one region skips the region step', (
    tester,
  ) async {
    await _openPicker(tester, _FakeStorage(), []);

    await tester.tap(_tile('دولة ص'));
    await tester.pumpAndSettle();

    expect(_tile('مدينة أ'), findsOneWidget);
    expect(_tile('منطقة ١'), findsNothing);
    // Country chip + city chip only.
    expect(find.byType(CityPickerChip), findsNWidgets(2));
  });

  testWidgets('search ignores teh marbuta and resets after a selection', (
    tester,
  ) async {
    await _openPicker(tester, _FakeStorage(), []);

    await tester.enterText(find.byType(TextField), 'دوله ص');
    await tester.pumpAndSettle();
    expect(_tile('دولة ص'), findsOneWidget);
    expect(_tile('دولة س'), findsNothing);

    await tester.tap(_tile('دولة ص'));
    await tester.pumpAndSettle();

    final field = tester.widget<TextField>(find.byType(TextField));
    expect(field.controller!.text, isEmpty);
  });

  testWidgets('removing the country chip returns to the first step', (
    tester,
  ) async {
    await _openPicker(tester, _FakeStorage(), []);

    await tester.tap(_tile('دولة س'));
    await tester.pumpAndSettle();
    expect(_tile('منطقة ١'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.close).first);
    await tester.pumpAndSettle();

    expect(_tile('دولة س'), findsOneWidget);
    expect(_tile('دولة ص'), findsOneWidget);
  });
}

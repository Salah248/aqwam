import 'package:aqwam/features/city_picker/data/selected_location_storage_impl.dart';
import 'package:aqwam/features/city_picker/domain/entities/selected_location.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:aqwam/core/errors/result.dart';
import '../../core/logging/fake_app_logger.dart';

// Test fixture only. Not real content.
const _location = SelectedLocation(
  countryCode: 'XX',
  countryNameAr: 'دولة س',
  countryNameEn: 'Country X',
  regionId: 'XX.1',
  regionNameAr: 'منطقة ١',
  regionNameEn: 'Region 1',
  cityId: 1,
  cityNameAr: 'مدينة أ',
  cityNameEn: 'City A',
  latitude: 30.5,
  longitude: 31,
  timeZone: 'Africa/Cairo',
);

void main() {
  late SelectedLocationStorageImpl storage;

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    storage = SelectedLocationStorageImpl(appLogger: FakeAppLogger());
  });

  test('returns null when nothing was saved', () async {
    expect(await storage.read(), const Success<SelectedLocation?>(null));
  });

  test('saves and reads back the same location', () async {
    await storage.save(_location);
    final result = await storage.read();
    expect(result, isA<Success<SelectedLocation?>>());
    expect((result as Success<SelectedLocation?>).value, _location);
  });

  test('a new save replaces the previous one', () async {
    await storage.save(_location);
    const other = SelectedLocation(
      countryCode: 'XX',
      countryNameAr: 'دولة س',
      countryNameEn: 'Country X',
      regionId: 'XX.2',
      regionNameAr: 'منطقة ٢',
      regionNameEn: 'Region 2',
      cityId: 2,
      cityNameAr: 'مدينة ب',
      cityNameEn: 'City B',
      latitude: 1,
      longitude: 2,
      timeZone: 'Africa/Cairo',
    );
    await storage.save(other);
    final result = await storage.read();
    expect(result, isA<Success<SelectedLocation?>>());
    expect((result as Success<SelectedLocation?>).value, other);
  });

  test('returns null for text that is not JSON', () async {
    SharedPreferences.setMockInitialValues({
      SelectedLocationStorageImpl.storageKey: 'not json',
    });
    final result = await storage.read();
    expect(result, isA<Success<SelectedLocation?>>());
    expect((result as Success<SelectedLocation?>).value, isNull);
  });

  test('returns null for an unknown version or missing fields', () async {
    SharedPreferences.setMockInitialValues({
      SelectedLocationStorageImpl.storageKey: '{"v":99}',
    });
    var result = await storage.read();
    expect(result, isA<Success<SelectedLocation?>>());
    expect((result as Success<SelectedLocation?>).value, isNull);

    SharedPreferences.setMockInitialValues({
      SelectedLocationStorageImpl.storageKey: '{"v":1,"cityId":1}',
    });
    result = await storage.read();
    expect(result, isA<Success<SelectedLocation?>>());
    expect((result as Success<SelectedLocation?>).value, isNull);
  });
}

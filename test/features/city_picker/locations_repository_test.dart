import 'package:aqwam/core/errors/failure.dart';
import 'package:aqwam/core/errors/result.dart';
import 'package:aqwam/features/city_picker/data/locations_repository_impl.dart';
import 'package:aqwam/features/city_picker/domain/entities/location_entities.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../core/logging/fake_app_logger.dart';

class _FailThenSucceedBundle extends CachingAssetBundle {
  int requests = 0;

  @override
  Future<ByteData> load(String key) async => ByteData(0);

  @override
  Future<String> loadString(String key, {bool cache = true}) async {
    requests++;
    if (requests == 1) throw StateError('Asset unavailable');
    return '{"countries":[]}';
  }
}

void main() {
  test('returns a storage failure and logs when the asset fails', () async {
    final bundle = _FailThenSucceedBundle();
    final logger = FakeAppLogger();
    final repository = LocationsRepositoryImpl(
      appLogger: logger,
      bundle: bundle,
    );

    expect(
      await repository.getCountries(),
      const Err<List<Country>>(StorageFailure()),
    );
    expect(logger.errors, ['Failed to load locations asset']);

    final retryResult = await repository.getCountries();
    expect(retryResult, isA<Success<List<Country>>>());
    expect((retryResult as Success<List<Country>>).value, isEmpty);
    expect(bundle.requests, 2);
  });
}

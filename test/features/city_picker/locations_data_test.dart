import 'dart:io';

import 'package:aqwam/features/city_picker/data/locations_parser.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final countries = parseCountries(
    File('assets/data/locations.json').readAsStringSync(),
  );

  test('contains the 22 Arab countries', () {
    expect(countries.length, 22);
  });

  test('contains the expected region and city counts', () {
    // Update these counts intentionally whenever locations.json is rebuilt.
    final regions = countries.fold<int>(
      0,
      (total, country) => total + country.regions.length,
    );
    final cities = countries.fold<int>(
      0,
      (countryTotal, country) =>
          countryTotal +
          country.regions.fold<int>(
            0,
            (regionTotal, region) => regionTotal + region.cities.length,
          ),
    );

    expect(regions, 328);
    expect(cities, 2310);
  });

  test('every country, region and city is complete and valid', () {
    for (final country in countries) {
      expect(country.nameAr, isNotEmpty, reason: country.code);
      expect(country.regionLabelAr, isNotEmpty, reason: country.code);
      expect(country.regions, isNotEmpty, reason: country.code);
      for (final region in country.regions) {
        expect(region.nameAr, isNotEmpty, reason: region.id);
        expect(region.cities, isNotEmpty, reason: region.id);
        for (final city in region.cities) {
          expect(city.nameAr, isNotEmpty, reason: '${city.id}');
          expect(city.timeZone, isNotEmpty, reason: '${city.id}');
          expect(city.latitude, inInclusiveRange(-90, 90));
          expect(city.longitude, inInclusiveRange(-180, 180));
        }
      }
    }
  });

  test('city ids are unique', () {
    final ids = [
      for (final c in countries)
        for (final r in c.regions)
          for (final city in r.cities) city.id,
    ];
    expect(ids.toSet().length, ids.length);
  });
}

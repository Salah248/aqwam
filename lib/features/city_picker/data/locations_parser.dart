import 'dart:convert';

import '../domain/entities/location_entities.dart';

/// دالة top-level عشان تشتغل داخل compute (isolate).
List<Country> parseCountries(String source) {
  final root = jsonDecode(source) as Map<String, dynamic>;
  final countries = root['countries'] as List<dynamic>;
  return countries
      .map((c) => _country(c as Map<String, dynamic>))
      .toList(growable: false);
}

Country _country(Map<String, dynamic> j) => Country(
  code: j['code'] as String,
  nameAr: j['ar'] as String,
  nameEn: j['en'] as String,
  regionLabelAr: j['regionAr'] as String,
  regionLabelEn: j['regionEn'] as String,
  regions: (j['regions'] as List<dynamic>)
      .map((r) => _region(r as Map<String, dynamic>))
      .toList(growable: false),
);

Region _region(Map<String, dynamic> j) => Region(
  id: j['id'] as String,
  nameAr: j['ar'] as String,
  nameEn: j['en'] as String,
  cities: (j['cities'] as List<dynamic>)
      .map((c) => _city(c as Map<String, dynamic>))
      .toList(growable: false),
);

City _city(Map<String, dynamic> j) => City(
  id: j['id'] as int,
  nameAr: j['ar'] as String,
  nameEn: j['en'] as String,
  latitude: (j['lat'] as num).toDouble(),
  longitude: (j['lng'] as num).toDouble(),
  timeZone: j['tz'] as String,
);

// Console output is the only UI of these build scripts.
// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

const rawDir = 'tool/data/raw';
const outFile = 'assets/data/locations.json';
const missingFile = 'tool/data/missing_ar.txt';

/// الدول العربية (أكواد ISO). أكواد جغرافية، مش نص ديني.
const arabCountries = {
  'DZ',
  'BH',
  'KM',
  'DJ',
  'EG',
  'IQ',
  'JO',
  'KW',
  'LB',
  'LY',
  'MR',
  'MA',
  'OM',
  'PS',
  'QA',
  'SA',
  'SO',
  'SD',
  'SY',
  'TN',
  'AE',
  'YE',
};

/// اسم المستوى الإداري لكل دولة (عربي، إنجليزي). راجعها بعينك.
const regionLabels = <String, (String, String)>{
  'SA': ('المنطقة', 'Region'),
  'AE': ('الإمارة', 'Emirate'),
  'MA': ('الجهة', 'Region'),
  'DZ': ('الولاية', 'Province'),
  'TN': ('الولاية', 'Governorate'),
  'SD': ('الولاية', 'State'),
  'MR': ('الولاية', 'Region'),
  'QA': ('البلدية', 'Municipality'),
  'LY': ('المنطقة', 'Region'),
  'SO': ('المحافظة', 'Province'),
  'DJ': ('الإقليم', 'Region'),
  'KM': ('الجزيرة', 'Island'),
};
const defaultLabel = ('المحافظة', 'Governorate');

Iterable<List<String>> rows(String name) sync* {
  for (final line in File('$rawDir/$name').readAsLinesSync()) {
    if (line.isEmpty || line.startsWith('#')) continue;
    yield line.split('\t');
  }
}

Map<int, String> loadMap(String path) {
  final f = File(path);
  if (!f.existsSync()) return {};
  final raw = jsonDecode(f.readAsStringSync()) as Map<String, dynamic>;
  return raw.map((k, v) => MapEntry(int.parse(k), v as String));
}

Future<void> main() async {
  // 1) الدول
  final countryEn = <String, String>{};
  final countryGeoId = <int, String>{};
  for (final r in rows('countryInfo.txt')) {
    final code = r[0];
    if (!arabCountries.contains(code)) continue;
    countryEn[code] = r[4];
    countryGeoId[int.parse(r[16])] = code;
  }

  // 2) المحافظات (admin1)
  final regionEn = <String, String>{};
  final regionGeoId = <int, String>{};
  for (final r in rows('admin1CodesASCII.txt')) {
    final id = r[0]; // مثل EG.11
    if (!arabCountries.contains(id.split('.').first)) continue;
    regionEn[id] = r[1];
    regionGeoId[int.parse(r[3])] = id;
  }

  // 3) المدن
  final cities = <int, Map<String, Object>>{};
  final cityRegion = <int, String>{};
  var skipped = 0;
  for (final r in rows('cities5000.txt')) {
    final cc = r[8];
    if (!arabCountries.contains(cc)) continue;
    final regionId = '$cc.${r[10]}';
    if (r[10].isEmpty || !regionEn.containsKey(regionId)) {
      skipped++;
      continue;
    }
    final id = int.parse(r[0]);
    cities[id] = {
      'id': id,
      'en': r[1],
      'lat': double.parse(r[4]),
      'lng': double.parse(r[5]),
      'tz': r[17],
      'pop': int.parse(r[14]),
    };
    cityRegion[id] = regionId;
  }

  // 4) الأسماء العربية (قراءة تدفقية، الملف كبير)
  final wanted = <int>{
    ...countryGeoId.keys,
    ...regionGeoId.keys,
    ...cities.keys,
  };
  final arName = <int, String>{};
  final arScore = <int, int>{};
  final lines = File(
    '$rawDir/alternateNamesV2.txt',
  ).openRead().transform(utf8.decoder).transform(const LineSplitter());
  await for (final line in lines) {
    final f = line.split('\t');
    if (f.length < 8 || f[2] != 'ar') continue;
    final id = int.tryParse(f[1]);
    if (id == null || !wanted.contains(id)) continue;
    if (f[6] == '1' || f[7] == '1') continue; // عامّي أو تاريخي
    final score = f[4] == '1' ? 2 : 1; // المفضّل أولًا
    if (score > (arScore[id] ?? 0)) {
      arScore[id] = score;
      arName[id] = f[3];
    }
  }
  final wikidata = loadMap('tool/data/ar_wikidata.json');
  final overrides = loadMap('tool/data/ar_overrides.json');
  // 5) التجميع
  final missing = <String>[];
  String ar(int id, String en, String where) {
    final n = overrides[id] ?? arName[id] ?? wikidata[id];
    if (n == null) missing.add('$where\t$id\t$en');
    return n ?? en;
  }

  final citiesByRegion = <String, List<Map<String, Object>>>{};
  cities.forEach((id, c) {
    c['ar'] = ar(id, c['en']! as String, 'city');
    citiesByRegion.putIfAbsent(cityRegion[id]!, () => []).add(c);
  });

  final regionsByCountry = <String, List<Map<String, Object>>>{};
  regionGeoId.forEach((geoId, regionId) {
    final list = citiesByRegion[regionId];
    if (list == null || list.isEmpty) return;
    list.sort((a, b) => (b['pop']! as int).compareTo(a['pop']! as int));
    for (final c in list) {
      c.remove('pop');
    }
    regionsByCountry.putIfAbsent(regionId.split('.').first, () => []).add({
      'id': regionId,
      'en': regionEn[regionId]!,
      'ar': ar(geoId, regionEn[regionId]!, 'region'),
      'cities': list,
    });
  });

  final countries = <Map<String, Object>>[];
  countryGeoId.forEach((geoId, code) {
    final regions = regionsByCountry[code];
    if (regions == null) return;
    final label = regionLabels[code] ?? defaultLabel;
    countries.add({
      'code': code,
      'en': countryEn[code]!,
      'ar': ar(geoId, countryEn[code]!, 'country'),
      'regionAr': label.$1,
      'regionEn': label.$2,
      'regions': regions,
    });
  });

  // 6) الكتابة
  File(outFile)
    ..createSync(recursive: true)
    ..writeAsStringSync(
      jsonEncode({'version': 1, 'countries': countries}),
    );
  File(missingFile).writeAsStringSync(missing.join('\n'));

  var regionCount = 0;
  var cityCount = 0;
  for (final c in countries) {
    final regions = c['regions']! as List;
    regionCount += regions.length;
    for (final r in regions) {
      cityCount += ((r as Map)['cities']! as List).length;
    }
  }
  print('countries: ${countries.length}');
  print('regions:   $regionCount');
  print('cities:    $cityCount (skipped without region: $skipped)');
  print('missing Arabic names: ${missing.length} (see $missingFile)');
  print('size: ${File(outFile).lengthSync() ~/ 1024} KB');
}

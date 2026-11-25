// Console output is the only UI of these build scripts.
// ignore_for_file: avoid_print
import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;

Future<void> main() async {
  final ids = File('tool/data/missing_ar.txt')
      .readAsLinesSync()
      .where((l) => l.isNotEmpty)
      .map((l) => l.split('\t')[1])
      .toList();

  final result = <String, String>{};
  final client = HttpClient()
    ..userAgent = 'AqwamBuild/1.0 (https://github.com/Salah248/aqwam)';

  for (var i = 0; i < ids.length; i += 150) {
    final batch = ids.sublist(i, math.min(i + 150, ids.length));
    final values = batch.map((id) => '"$id"').join(' ');
    final query =
        'SELECT ?gn ?label WHERE { VALUES ?gn { $values } '
        '?item wdt:P1566 ?gn . ?item rdfs:label ?label . '
        'FILTER(LANG(?label) = "ar") }';

    final req = await client.postUrl(
      Uri.parse('https://query.wikidata.org/sparql'),
    );
    req.headers
      ..contentType = ContentType(
        'application',
        'x-www-form-urlencoded',
        charset: 'utf-8',
      )
      ..set('Accept', 'application/sparql-results+json');
    req.write('format=json&query=${Uri.encodeQueryComponent(query)}');

    final res = await req.close();
    final body = await utf8.decodeStream(res);
    if (res.statusCode != 200) {
      final head = body.length > 200 ? body.substring(0, 200) : body;
      print('HTTP ${res.statusCode} at batch $i: $head');
      break;
    }

    final bindings =
        ((jsonDecode(body) as Map)['results'] as Map)['bindings'] as List;
    for (final b in bindings) {
      final m = b as Map;
      result[(m['gn'] as Map)['value'] as String] =
          (m['label'] as Map)['value'] as String;
    }
    print('batch ${i ~/ 150 + 1}: total found ${result.length}');
    await Future<void>.delayed(const Duration(seconds: 1));
  }

  File('tool/data/ar_wikidata.json').writeAsStringSync(jsonEncode(result));
  print('found ${result.length} of ${ids.length}');
  client.close();
}

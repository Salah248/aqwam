import 'package:aqwam/features/city_picker/domain/location_search.dart';
import 'package:flutter_test/flutter_test.dart';

typedef _Item = (String ar, String en);

List<_Item> _search(List<_Item> items, String q) => searchLocations<_Item>(
  items,
  q,
  nameAr: (i) => i.$1,
  nameEn: (i) => i.$2,
);

void main() {
  const cairo = ('القاهرة', 'Cairo');
  const maadi = ('المعادي', 'Maadi');
  const nasrCity = ('مدينة نصر', 'Nasr City');
  const nasrDin = ('نصر الدين', 'Nasr Eldin');
  final all = [cairo, maadi, nasrCity, nasrDin];

  test('empty query returns all items', () {
    expect(_search(all, '  '), all);
  });

  test('matches Arabic ignoring teh marbuta and diacritics', () {
    expect(_search(all, 'قاهره'), [cairo]);
    expect(_search(all, 'القَاهِرَة'), [cairo]);
  });

  test('matches English case-insensitively', () {
    expect(_search(all, 'MAA'), [maadi]);
  });

  test('items starting with the query come first', () {
    expect(_search(all, 'نصر'), [nasrDin, nasrCity]);
  });

  test('no match returns empty list', () {
    expect(_search(all, 'xyz'), isEmpty);
  });
}

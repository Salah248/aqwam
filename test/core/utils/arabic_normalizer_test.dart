import 'package:aqwam/core/utils/arabic_normalizer.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('normalizeSearch', () {
    test('removes diacritics and unifies teh marbuta', () {
      expect(normalizeSearch('  القَاهِرة '), 'القاهره');
    });

    test('unifies alef forms', () {
      expect(normalizeSearch('إسكندرية'), 'اسكندريه');
      expect(normalizeSearch('أبو ظبي'), 'ابو ظبي');
    });

    test('unifies alef maksura', () {
      expect(normalizeSearch('مصطفى'), 'مصطفي');
    });

    test('lowercases latin and collapses spaces', () {
      expect(normalizeSearch('  Nasr   CITY '), 'nasr city');
    });
  });
}

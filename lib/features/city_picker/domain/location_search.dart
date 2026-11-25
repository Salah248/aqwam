import '../../../core/utils/arabic_normalizer.dart';

/// بحث عام على أي قائمة (دول، محافظات، مدن).
/// اللي يبدأ بالنص يظهر أول، وبعده اللي يحتويه.
List<T> searchLocations<T>(
  List<T> items,
  String query, {
  required String Function(T item) nameAr,
  required String Function(T item) nameEn,
}) {
  final q = normalizeSearch(query);
  if (q.isEmpty) return items;

  final startsWith = <T>[];
  final contains = <T>[];
  for (final item in items) {
    final names = [
      normalizeSearch(nameAr(item)),
      normalizeSearch(nameEn(item)),
    ];
    if (names.any((n) => n.startsWith(q))) {
      startsWith.add(item);
    } else if (names.any((n) => n.contains(q))) {
      contains.add(item);
    }
  }
  return [...startsWith, ...contains];
}

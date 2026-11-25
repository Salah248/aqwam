final _diacritics = RegExp('[\u064B-\u065F\u0670\u0640]'); // تشكيل + تطويل
final _alefs = RegExp('[\u0623\u0625\u0622\u0671]'); // أ إ آ ٱ
final _spaces = RegExp(r'\s+');

/// يوحّد النص للبحث: يشيل التشكيل، ويوحّد الألف والياء والتاء المربوطة.
String normalizeSearch(String input) {
  return input
      .replaceAll(_diacritics, '')
      .replaceAll(_alefs, '\u0627') // ا
      .replaceAll('\u0649', '\u064A') // ى ← ي
      .replaceAll('\u0629', '\u0647') // ة ← ه
      .toLowerCase()
      .trim()
      .replaceAll(_spaces, ' ');
}

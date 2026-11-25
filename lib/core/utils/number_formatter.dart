// Purpose: provide the single shared number-formatting contract.
// Contract: Arabic defaults to Arabic-Indic digits and English to Western digits.
enum DigitStyle { auto, western, arabicIndic }

String formatInt(
  int value, {
  required String languageCode,
  DigitStyle style = DigitStyle.auto,
}) {
  final text = value.toString();
  if (!_shouldUseArabicIndic(style, languageCode)) {
    return text;
  }
  return text
      .split('')
      .map(
        _toArabicDigit,
      )
      .join();
}

bool _shouldUseArabicIndic(DigitStyle style, String languageCode) {
  switch (style) {
    case DigitStyle.western:
      return false;
    case DigitStyle.arabicIndic:
      return true;
    case DigitStyle.auto:
      return languageCode == 'ar';
  }
}

String _toArabicDigit(String char) {
  final code = char.codeUnitAt(0);
  if (code < 48 || code > 57) {
    return char;
  }
  return String.fromCharCode((code - 48) + 1632);
}

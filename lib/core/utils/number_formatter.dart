import 'package:intl/intl.dart';

enum DigitStyle { arabicIndic, western }

final class NumberFormatter {
  const NumberFormatter();

  String format(int value, DigitStyle style) {
    final western = NumberFormat.decimalPattern('en').format(value);
    if (style == DigitStyle.western) {
      return western;
    }
    return western
        .replaceAll('0', '٠')
        .replaceAll('1', '١')
        .replaceAll('2', '٢')
        .replaceAll('3', '٣')
        .replaceAll('4', '٤')
        .replaceAll('5', '٥')
        .replaceAll('6', '٦')
        .replaceAll('7', '٧')
        .replaceAll('8', '٨')
        .replaceAll('9', '٩');
  }
}

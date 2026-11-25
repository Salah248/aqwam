import 'package:aqwam/core/utils/number_formatter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('should return text with the correct style after apply format', () {
    expect(formatInt(3, languageCode: 'ar'), '٣');
    expect(formatInt(3, languageCode: 'en'), '3');
    expect(formatInt(2310, languageCode: 'ar'), '٢٣١٠');
    expect(formatInt(0, languageCode: 'ar'), '٠');
    expect(formatInt(3, languageCode: 'ar', style: DigitStyle.western), '3');
    expect(
      formatInt(3, languageCode: 'en', style: DigitStyle.arabicIndic),
      '٣',
    );
    expect(formatInt(-5, languageCode: 'ar'), '-٥');
  });
}

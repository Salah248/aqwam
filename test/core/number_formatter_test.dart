import 'package:flutter_test/flutter_test.dart';

import 'package:aqwam/core/utils/number_formatter.dart';

void main() {
  const formatter = NumberFormatter();

  test('should format Arabic-Indic digits', () {
    expect(formatter.format(1234, DigitStyle.arabicIndic), '١,٢٣٤');
  });

  test('should format Western digits', () {
    expect(formatter.format(1234, DigitStyle.western), '1,234');
  });
}

import 'package:flutter_test/flutter_test.dart';

import 'package:aqwam/app/aqwam_app.dart';
import 'package:aqwam/core/di/injection.dart';

void main() {
  testWidgets('renders the Arabic shell', (tester) async {
    configureDependencies();
    await tester.pumpWidget(const AqwamApp());
    await tester.pumpAndSettle();

    expect(find.text('الرئيسية'), findsAtLeast(1));
    expect(find.text('المصحف'), findsOneWidget);
    expect(find.text('الإعدادات'), findsOneWidget);
  });
}

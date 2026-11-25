import 'package:aqwam/core/errors/result.dart';
import 'package:aqwam/core/l10n/app_localizations.dart';
import 'package:aqwam/core/platform/location_permission.dart';
import 'package:aqwam/core/platform/notification_permission.dart';
import 'package:aqwam/core/theme/app_theme.dart';
import 'package:aqwam/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

class _FakeLocationPermission implements LocationPermissionGateway {
  _FakeLocationPermission({required this.granted});

  final bool granted;
  int calls = 0;

  @override
  Future<Result<bool>> request() async {
    calls++;
    return Success(granted);
  }
}

class _FakeNotificationPermission implements NotificationPermissionGateway {
  _FakeNotificationPermission({required this.granted});

  final bool granted;
  int calls = 0;

  @override
  Future<Result<bool>> request() async {
    calls++;
    return Success(granted);
  }
}

Future<void> _pumpOnboarding(
  WidgetTester tester, {
  required bool locationGranted,
  required bool notificationGranted,
}) async {
  tester.view
    ..physicalSize = const Size(1080, 2400)
    ..devicePixelRatio = 3;
  addTearDown(tester.view.reset);

  final locationPermission = _FakeLocationPermission(granted: locationGranted);
  final notificationPermission = _FakeNotificationPermission(
    granted: notificationGranted,
  );
  final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => OnboardingPage(
          locationPermission: locationPermission,
          notificationPermission: notificationPermission,
        ),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const Scaffold(body: Text('home screen')),
      ),
    ],
  );

  await tester.pumpWidget(
    ScreenUtilInit(
      designSize: const Size(360, 800),
      builder: (context, child) => MaterialApp.router(
        theme: buildLightTheme(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale('en'),
        routerConfig: router,
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('location granted advances onboarding using the fake', (
    tester,
  ) async {
    await _pumpOnboarding(
      tester,
      locationGranted: true,
      notificationGranted: true,
    );
    final localizations = AppLocalizations.of(
      tester.element(find.byType(OnboardingPage)),
    );

    await tester.tap(find.text(localizations.onboardingStart));
    await tester.pumpAndSettle();
    await tester.tap(find.text(localizations.onboardingAllowLocation));
    await tester.pumpAndSettle();

    expect(
      find.text(localizations.onboardingAllowNotifications),
      findsOneWidget,
    );
  });

  testWidgets('location denied still allows manual onboarding progress', (
    tester,
  ) async {
    await _pumpOnboarding(
      tester,
      locationGranted: false,
      notificationGranted: false,
    );
    final localizations = AppLocalizations.of(
      tester.element(find.byType(OnboardingPage)),
    );

    await tester.tap(find.text(localizations.onboardingStart));
    await tester.pumpAndSettle();
    await tester.tap(find.text(localizations.onboardingAllowLocation));
    await tester.pumpAndSettle();

    expect(
      find.text(localizations.onboardingAllowNotifications),
      findsOneWidget,
    );
  });

  testWidgets('notification granted finishes onboarding using the fake', (
    tester,
  ) async {
    await _pumpOnboarding(
      tester,
      locationGranted: true,
      notificationGranted: true,
    );
    final localizations = AppLocalizations.of(
      tester.element(find.byType(OnboardingPage)),
    );

    await tester.tap(find.text(localizations.onboardingStart));
    await tester.pumpAndSettle();
    await tester.tap(find.text(localizations.onboardingAllowLocation));
    await tester.pumpAndSettle();
    await tester.tap(find.text(localizations.onboardingAllowNotifications));
    await tester.pumpAndSettle();

    expect(find.text('home screen'), findsOneWidget);
  });

  testWidgets('notification denied still completes onboarding', (
    tester,
  ) async {
    await _pumpOnboarding(
      tester,
      locationGranted: false,
      notificationGranted: false,
    );
    final localizations = AppLocalizations.of(
      tester.element(find.byType(OnboardingPage)),
    );

    await tester.tap(find.text(localizations.onboardingStart));
    await tester.pumpAndSettle();
    await tester.tap(find.text(localizations.onboardingAllowLocation));
    await tester.pumpAndSettle();
    await tester.tap(find.text(localizations.onboardingAllowNotifications));
    await tester.pumpAndSettle();

    expect(find.text('home screen'), findsOneWidget);
  });
}

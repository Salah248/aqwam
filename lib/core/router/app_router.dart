import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

import 'package:aqwam/core/l10n/app_localizations.dart';

import '../../features/onboarding/presentation/pages/onboarding_page.dart';

abstract final class AppRoutes {
  static const onboarding = '/';
  static const home = '/home';
  static const quran = '/quran';
  static const adhkar = '/adhkar';
  static const prayerTimes = '/prayer-times';
  static const settings = '/settings';
}

final appRouter = GoRouter(
  initialLocation: AppRoutes.onboarding,
  routes: [
    _route(
      AppRoutes.onboarding,
      (context, state) => const OnboardingPage(),
    ),
    _route(
      AppRoutes.home,
      (context, state) => const PlaceholderPage(title: 'Home'),
    ),
    _route(
      AppRoutes.quran,
      (context, state) => const PlaceholderPage(title: 'Quran'),
    ),
    _route(
      AppRoutes.adhkar,
      (context, state) => const PlaceholderPage(title: 'Adhkar'),
    ),
    _route(
      AppRoutes.prayerTimes,
      (context, state) => const PlaceholderPage(title: 'Prayer Times'),
    ),
    _route(
      AppRoutes.settings,
      (context, state) => const PlaceholderPage(title: 'Settings'),
    ),
  ],
);

GoRoute _route(
  String path,
  Widget Function(BuildContext, GoRouterState)? builder,
) => GoRoute(
  path: path,
  builder:
      builder ??
      (context, state) =>
          PlaceholderPage(title: AppLocalizations.of(context).appTitle),
);

final class PlaceholderPage extends StatelessWidget {
  const PlaceholderPage({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(title)),
  );
}

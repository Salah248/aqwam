import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

import 'package:aqwam/core/l10n/app_localizations.dart';

abstract final class AppRoutes {
  static const home = '/';
  static const quran = '/quran';
  static const adhkar = '/adhkar';
  static const prayerTimes = '/prayer-times';
  static const settings = '/settings';
}

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    _route(AppRoutes.home, (l10n) => l10n.home),
    _route(AppRoutes.quran, (l10n) => l10n.quran),
    _route(AppRoutes.adhkar, (l10n) => l10n.adhkar),
    _route(AppRoutes.prayerTimes, (l10n) => l10n.prayerTimes),
    _route(AppRoutes.settings, (l10n) => l10n.settings),
  ],
);

GoRoute _route(String path, String Function(AppLocalizations) title) => GoRoute(
  path: path,
  builder: (context, state) => PlaceholderPage(
    title: title(AppLocalizations.of(context)),
  ),
);

final class PlaceholderPage extends StatelessWidget {
  const PlaceholderPage({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(title)),
  );
}

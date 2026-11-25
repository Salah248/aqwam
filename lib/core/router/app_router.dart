import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:aqwam/core/l10n/app_localizations.dart';
import 'package:aqwam/core/di/injection.dart';
import 'package:aqwam/features/city_picker/presentation/cubit/city_picker_cubit.dart';
import 'package:aqwam/core/platform/location_permission.dart';
import 'package:aqwam/core/platform/notification_permission.dart';

import '../../features/onboarding/presentation/pages/onboarding_page.dart';
import '../../features/city_picker/presentation/pages/city_picker_page.dart';

abstract final class AppRoutes {
  static const onboarding = '/';
  static const home = '/home';
  static const quran = '/quran';
  static const adhkar = '/adhkar';
  static const prayerTimes = '/prayer-times';
  static const settings = '/settings';
  static const cityPicker = '/city-picker';
}

final appRouter = GoRouter(
  initialLocation: AppRoutes.onboarding,
  routes: [
    _route(
      AppRoutes.onboarding,
      (context, state) => OnboardingPage(
        locationPermission: getIt<LocationPermissionGateway>(),
        notificationPermission: getIt<NotificationPermissionGateway>(),
      ),
    ),
    _route(
      AppRoutes.home,
      (context, state) => PlaceholderPage(
        title: AppLocalizations.of(context).home,
      ),
    ),
    _route(
      AppRoutes.cityPicker,
      (context, state) => BlocProvider(
        create: (_) => getIt<CityPickerCubit>(
          param1: Localizations.localeOf(context).languageCode,
        )..load(),
        child: const CityPickerPage(),
      ),
    ),
    _route(
      AppRoutes.quran,
      (context, state) => PlaceholderPage(
        title: AppLocalizations.of(context).quran,
      ),
    ),
    _route(
      AppRoutes.adhkar,
      (context, state) => PlaceholderPage(
        title: AppLocalizations.of(context).adhkar,
      ),
    ),
    _route(
      AppRoutes.prayerTimes,
      (context, state) => PlaceholderPage(
        title: AppLocalizations.of(context).prayerTimes,
      ),
    ),
    _route(
      AppRoutes.settings,
      (context, state) => PlaceholderPage(
        title: AppLocalizations.of(context).settings,
      ),
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

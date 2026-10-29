import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:aqwam/core/app_config.dart';
import 'package:aqwam/core/di/injection.dart';
import 'package:aqwam/core/l10n/app_localizations.dart';
import 'package:aqwam/core/router/app_router.dart';
import 'package:aqwam/core/theme/app_theme.dart';
import 'package:aqwam/features/settings/domain/entities/app_settings.dart';
import 'package:aqwam/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:aqwam/features/settings/presentation/cubit/settings_state.dart';

class AqwamApp extends StatelessWidget {
  const AqwamApp({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => getIt<SettingsCubit>()..load(),
    child: BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        final settings = state is SettingsReady
            ? state.settings
            : const AppSettings.defaults();
        return MaterialApp.router(
          title: AppConfig.appName,
          debugShowCheckedModeBanner: false,
          theme: buildAppTheme(Brightness.light),
          darkTheme: buildAppTheme(Brightness.dark),
          themeMode: settings.themeMode,
          locale: settings.locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          routerConfig: appRouter,
        );
      },
    ),
  );
}

final class AppSettingsFallback {
  const AppSettingsFallback();

  ThemeMode get themeMode => ThemeMode.light;
  Locale get locale => const Locale('ar');
}

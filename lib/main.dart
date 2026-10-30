import 'package:aqwam/core/di/injection.dart';
import 'package:aqwam/core/l10n/app_localizations.dart';
import 'package:aqwam/core/router/app_router.dart';
import 'package:aqwam/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupDependencies();
  runApp(
    ScreenUtilInit(
      designSize: const Size(360, 800),
      builder: (context, child) => MaterialApp.router(
        debugShowCheckedModeBanner: false,
        onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
        theme: buildLightTheme(),
        darkTheme: buildDarkTheme(),
        locale: const Locale('ar'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: appRouter,
      ),
    ),
  );
}

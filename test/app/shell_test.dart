import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:aqwam/app/shell_page.dart';
import 'package:aqwam/core/l10n/app_localizations.dart';
import 'package:aqwam/core/theme/app_theme.dart';
import 'package:aqwam/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:aqwam/features/settings/domain/usecases/load_settings_usecase.dart';
import 'package:aqwam/features/settings/domain/usecases/save_settings_usecase.dart';
import '../features/settings/settings_test.dart';

void main() {
  for (final brightness in Brightness.values) {
    testWidgets('should render shell in $brightness Arabic RTL', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('ar'),
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          theme: buildAppTheme(brightness),
          home: BlocProvider(
            create: (_) => SettingsCubit(
              const LoadSettingsUsecase(FakeRepository()),
              const SaveSettingsUsecase(FakeRepository()),
            )..load(),
            child: const ShellPage(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('الرئيسية'), findsAtLeast(1));
      expect(find.byType(NavigationBar), findsOneWidget);
      expect(
        tester
            .element(find.byType(ShellPage))
            .findAncestorWidgetOfExactType<Directionality>(),
        isNotNull,
      );
    });
  }

  testWidgets('should render the English shell', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('en'),
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        theme: buildAppTheme(Brightness.light),
        home: BlocProvider(
          create: (_) => SettingsCubit(
            const LoadSettingsUsecase(FakeRepository()),
            const SaveSettingsUsecase(FakeRepository()),
          )..load(),
          child: const ShellPage(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Home'), findsAtLeast(1));
  });
}

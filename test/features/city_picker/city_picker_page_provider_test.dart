import 'package:aqwam/core/l10n/app_localizations.dart';
import 'package:aqwam/core/theme/app_theme.dart';
import 'package:aqwam/features/city_picker/presentation/cubit/city_picker_cubit.dart';
import 'package:aqwam/features/city_picker/presentation/cubit/city_picker_state.dart';
import 'package:aqwam/features/city_picker/presentation/pages/city_picker_page.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockCityPickerCubit extends MockCubit<CityPickerState>
    implements CityPickerCubit {}

void main() {
  testWidgets('renders under BlocProvider.value with a mock Cubit', (
    tester,
  ) async {
    final cubit = _MockCityPickerCubit();
    when(() => cubit.state).thenReturn(const CityPickerState());

    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(360, 800),
        builder: (context, child) => MaterialApp(
          theme: buildLightTheme(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: const Locale('en'),
          home: BlocProvider<CityPickerCubit>.value(
            value: cubit,
            child: const CityPickerPage(),
          ),
        ),
      ),
    );
    await tester.pump();

    expect(find.text('Choose city'), findsOneWidget);
    expect(find.byType(CityPickerPage), findsOneWidget);
  });
}

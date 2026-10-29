import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:aqwam/core/l10n/app_localizations.dart';
import 'package:aqwam/core/theme/aqwam_tokens.dart';
import 'package:aqwam/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:aqwam/features/settings/presentation/cubit/settings_state.dart';

class ShellPage extends StatefulWidget {
  const ShellPage({super.key});

  @override
  State<ShellPage> createState() => _ShellPageState();
}

class _ShellPageState extends State<ShellPage> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final labels = [
      l10n.home,
      l10n.quran,
      l10n.adhkar,
      l10n.prayerTimes,
      l10n.settings,
    ];
    final icons = [
      Icons.home_outlined,
      Icons.menu_book_outlined,
      Icons.auto_awesome_outlined,
      Icons.access_time_outlined,
      Icons.settings_outlined,
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(labels[_index]),
        backgroundColor: Theme.of(context).extension<AqwamTokens>()!.surface,
      ),
      body: _index == 4
          ? const _SettingsPlaceholder()
          : _PlaceholderScreen(label: labels[_index]),
      bottomNavigationBar: NavigationBar(
        height: AqwamTokens.bottomNav,
        selectedIndex: _index,
        onDestinationSelected: (index) => setState(() => _index = index),
        destinations: [
          for (var index = 0; index < labels.length; index++)
            NavigationDestination(
              icon: Icon(icons[index]),
              label: labels[index],
            ),
        ],
      ),
    );
  }
}

class _PlaceholderScreen extends StatelessWidget {
  const _PlaceholderScreen({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) => Center(
    child: Text(
      AppLocalizations.of(context).placeholder,
      semanticsLabel: label,
    ),
  );
}

class _SettingsPlaceholder extends StatelessWidget {
  const _SettingsPlaceholder();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        if (state is! SettingsReady) {
          return Center(child: Text(l10n.placeholder));
        }
        final isDark = state.settings.themeMode == ThemeMode.dark;
        return ListView(
          padding: const EdgeInsets.all(AqwamTokens.space2),
          children: [
            Text(l10n.theme),
            SwitchListTile(
              title: Text(isDark ? l10n.darkTheme : l10n.lightTheme),
              value: isDark,
              onChanged: (value) => context.read<SettingsCubit>().setThemeMode(
                value ? ThemeMode.dark : ThemeMode.light,
              ),
            ),
          ],
        );
      },
    );
  }
}

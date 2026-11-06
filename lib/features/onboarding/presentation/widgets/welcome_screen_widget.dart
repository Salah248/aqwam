import 'package:flutter/material.dart';

import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/theme/aqwam_tokens.dart';

class WelcomeScreenWidget extends StatelessWidget {
  const WelcomeScreenWidget({this.onPressed, super.key});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final _ = theme.extension<AqwamColors>()!;
    final _ = AppLocalizations.of(context);

    return const SafeArea(
      child: Column(),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/theme/aqwam_tokens.dart';

class SkipWidget extends StatelessWidget {
  const SkipWidget({this.onPressed, super.key});
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        minimumSize: Size.square(AqwamSize.touchTarget),
        padding: EdgeInsets.zero,
        tapTargetSize: MaterialTapTargetSize.padded,
      ),
      child: Text(
        AppLocalizations.of(context).onboardingSkip,
        style: Theme.of(context).textTheme.labelMedium,
      ),
    );
  }
}

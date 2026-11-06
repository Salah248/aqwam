import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../theme/aqwam_tokens.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    required this.text,
    this.onPressed,
    this.width,
    this.height,
    super.key,
  });
  final void Function()? onPressed;
  final double? width;
  final double? height;
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context);
    return SizedBox(
      width: double.infinity,
      height: AqwamSize.buttonHeight,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: theme.colorScheme.primary,
          foregroundColor: theme.colorScheme.onPrimary,
          elevation: 0,
          padding: EdgeInsets.symmetric(
            horizontal: AqwamSpacing.space2,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AqwamRadius.control),
          ),
        ),
        child: Text(
          localizations.onboardingStart,
          style: theme.textTheme.labelLarge,
        ),
      ),
    );
  }
}

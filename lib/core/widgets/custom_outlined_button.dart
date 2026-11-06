import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../theme/aqwam_tokens.dart';

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton({
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
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: theme.colorScheme.surface,
          foregroundColor: theme.colorScheme.onSurface,
          elevation: 0,
          padding: EdgeInsets.symmetric(
            horizontal: AqwamSpacing.space2,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AqwamRadius.control),
          ),
          side: BorderSide(
            color: theme.colorScheme.outline,
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

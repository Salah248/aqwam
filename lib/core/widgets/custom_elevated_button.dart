import 'package:flutter/material.dart';

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
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
        elevation: 0,
        minimumSize: Size(width ?? double.infinity, height ?? AqwamTokens.s44),
        tapTargetSize: MaterialTapTargetSize.padded,
        padding: EdgeInsets.symmetric(
          horizontal: AqwamTokens.p14,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AqwamTokens.r10),
        ),
      ),
      child: Text(
        text,
        style: theme.textTheme.labelLarge,
      ),
    );
  }
}

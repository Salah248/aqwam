import 'package:flutter/material.dart';

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
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: theme.colorScheme.surface,
        foregroundColor: theme.colorScheme.onSurface,
        elevation: 0,
        minimumSize: Size(width ?? double.infinity, height ?? AqwamSize.s44),
        tapTargetSize: MaterialTapTargetSize.padded,
        padding: EdgeInsets.symmetric(
          horizontal: AqwamSpacing.p14,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AqwamRadius.r10),
        ),
        side: BorderSide(
          color: theme.colorScheme.outline,
        ),
      ),
      child: Text(
        text,
        style: theme.textTheme.labelLarge,
      ),
    );
  }
}

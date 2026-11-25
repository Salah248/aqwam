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
    final colors = theme.extension<AqwamColors>()!;
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: colors.surface,
        foregroundColor: colors.text,
        elevation: 0,
        minimumSize: Size(width ?? double.infinity, height ?? AqwamSize.h44),
        tapTargetSize: MaterialTapTargetSize.padded,
        padding: EdgeInsets.symmetric(
          horizontal: AqwamSpacing.w14,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AqwamRadius.r10),
        ),
        side: BorderSide(
          color: colors.divider,
        ),
      ),
      child: Text(
        text,
        style: theme.textTheme.labelLarge,
      ),
    );
  }
}

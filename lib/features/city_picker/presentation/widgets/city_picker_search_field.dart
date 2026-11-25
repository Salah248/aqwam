import 'package:flutter/material.dart';

import '../../../../core/theme/aqwam_tokens.dart';

class CityPickerSearchField extends StatelessWidget {
  const CityPickerSearchField({
    required this.onChanged,
    required this.controller,
    required this.hintText,
    super.key,
  });

  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String> onChanged;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.extension<AqwamColors>()!;
    return TextField(
      controller: controller,
      textInputAction: TextInputAction.search,
      cursorWidth: .8,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: theme.textTheme.labelSmall?.copyWith(
          color: colors.textSecondary,
          fontSize: AqwamFontSize.f12d5,
        ),
        prefixIcon: Icon(
          Icons.search,
          color: colors.textSecondary,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AqwamRadius.r10),
          borderSide: BorderSide(color: colors.divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AqwamRadius.r10),
          borderSide: BorderSide(color: colors.divider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AqwamRadius.r10),
          borderSide: BorderSide(color: colors.divider),
        ),
        filled: true,
        fillColor: colors.surface,
      ),
    );
  }
}

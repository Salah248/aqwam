import 'package:flutter/material.dart';

import '../../../../core/theme/aqwam_tokens.dart';

class CityPickerChip extends StatelessWidget {
  const CityPickerChip({
    required this.label,
    this.selected = false,
    this.onDeleted,
    super.key,
  });

  final String label;
  final bool selected;
  final VoidCallback? onDeleted;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AqwamColors>()!;
    return Chip(
      label: Text(label),
      backgroundColor: selected ? colors.primary : colors.surface,
      deleteIcon: selected ? Icon(Icons.close, color: colors.onPrimary) : null,
      onDeleted: selected ? onDeleted : null,
      labelStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
        color: selected ? colors.onPrimary : colors.text,
      ),
      side: BorderSide(
        color: selected ? colors.primary : colors.divider,
      ),
      shape: const StadiumBorder(),
    );
  }
}

import 'package:aqwam/core/extension/color_opacity.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/aqwam_tokens.dart';

class CityTile extends StatelessWidget {
  const CityTile({
    required this.onTap,
    this.showDivider = false,
    this.selected = false,
    this.label,
    super.key,
  });

  final VoidCallback onTap;
  final bool showDivider;
  final bool selected;
  final String?
  label; // Placeholder for the city name, replace with actual data when available

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AqwamColors>()!;
    return Column(
      children: [
        ListTile(
          selected: selected,
          selectedColor: colors.onPrimary,
          selectedTileColor: colors.primary.colorOpacity(0.2),
          contentPadding: EdgeInsetsDirectional.symmetric(
            horizontal: AqwamSpacing.w12,
          ),
          onTap: onTap,
          leading: Icon(
            Icons.location_on_outlined,
            color: colors.primary,
          ),
          title: Text(
            label ?? '',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          trailing: selected
              ? Icon(Icons.check_circle, color: colors.primary)
              : Icon(Icons.chevron_right, color: colors.textSecondary),
        ),
        if (showDivider)
          Divider(
            height: 1,
            thickness: 1,
            color: colors.divider,
          ),
      ],
    );
  }
}

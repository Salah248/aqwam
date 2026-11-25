import 'package:flutter/material.dart';

import '../../../../core/theme/aqwam_tokens.dart';
import 'city_tile.dart';

class CityPickerList<T> extends StatelessWidget {
  const CityPickerList({
    required this.items,
    required this.labelOf,
    required this.onTap,
    required this.emptyText,
    this.isSelected,
    super.key,
  });

  final List<T> items;
  final String Function(T item) labelOf;
  final void Function(T item) onTap;
  final String emptyText;
  final bool Function(T item)? isSelected;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AqwamColors>()!;
    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: colors.divider),
        borderRadius: BorderRadius.circular(AqwamRadius.r12),
      ),
      child: items.isEmpty
          ? Padding(
              padding: EdgeInsetsDirectional.all(AqwamSpacing.w16),
              child: Center(
                child: Text(
                  emptyText,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: colors.textSecondary,
                  ),
                ),
              ),
            )
          : Column(
              children: [
                for (var i = 0; i < items.length; i++)
                  CityTile(
                    label: labelOf(items[i]),
                    selected: isSelected?.call(items[i]) ?? false,
                    showDivider: i < items.length - 1,
                    onTap: () => onTap(items[i]),
                  ),
              ],
            ),
    );
  }
}

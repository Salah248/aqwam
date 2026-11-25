import 'package:flutter/material.dart';

import '../../../../core/theme/aqwam_tokens.dart';
import '../../../../core/widgets/custom_elevated_button.dart';

class CityPickerConfirmationBar extends StatelessWidget {
  const CityPickerConfirmationBar({
    required this.summary,
    required this.buttonLabel,
    required this.onPressed,
    super.key,
  });

  final String summary;
  final String buttonLabel;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AqwamColors>()!;
    return SafeArea(
      top: false,
      child: Container(
        padding: EdgeInsetsDirectional.fromSTEB(
          AqwamSpacing.w16,
          AqwamSpacing.h8,
          AqwamSpacing.w16,
          AqwamSpacing.h8,
        ),
        decoration: BoxDecoration(
          color: colors.surface,
          border: Border(
            top: BorderSide(
              color: colors.divider,
            ),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              summary,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            SizedBox(height: AqwamSpacing.h8),
            SizedBox(
              width: double.infinity,
              child: CustomElevatedButton(
                text: buttonLabel,
                onPressed: onPressed,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

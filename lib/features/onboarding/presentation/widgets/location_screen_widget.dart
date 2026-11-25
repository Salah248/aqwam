import 'package:aqwam/core/assets/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/theme/aqwam_tokens.dart';

class LocationScreenWidget extends StatelessWidget {
  const LocationScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.extension<AqwamColors>()!;
    final localizations = AppLocalizations.of(context);

    return SizedBox.expand(
      child: Stack(
        children: [
          Positioned(
            top: AqwamSpacing.onboardingLocationIconTop,
            left: 0,
            right: 0,
            child: ExcludeSemantics(
              child: SvgPicture.asset(
                AssetsManager.onboardingLocationIcon,
                width: AqwamSize.w64,
                height: AqwamSize.h64,
                colorFilter: ColorFilter.mode(
                  colors.primary,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          Positioned(
            top: AqwamSpacing.onboardingLocationTitleTop,
            left: 0,
            right: 0,
            child: Text(
              localizations.onboardingLocationTitle,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleLarge,
            ),
          ),
          Positioned(
            top: AqwamSpacing.onboardingLocationDescriptionTop,
            left: AqwamSpacing.onboardingDescriptionInset,
            right: AqwamSpacing.onboardingDescriptionInset,
            child: Text(
              localizations.onboardingLocationDescription,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: AqwamFontWeight.fw600,
                height: AqwamLineHeight.lh2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

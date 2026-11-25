import 'package:aqwam/core/assets/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/theme/aqwam_tokens.dart';

class WelcomeScreenWidget extends StatelessWidget {
  const WelcomeScreenWidget({this.onPressed, super.key});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.extension<AqwamColors>()!;
    final localizations = AppLocalizations.of(context);

    return SizedBox.expand(
      child: Stack(
        children: [
          Positioned(
            top: AqwamSpacing.onboardingVisualTop,
            left: 0,
            right: 0,
            child: ExcludeSemantics(
              child: SvgPicture.asset(
                AssetsManager.onboardingWelcomeOrnament,
                width: AqwamSize.w150,
                height: AqwamSize.h150,
                colorFilter: ColorFilter.mode(
                  colors.primary,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          Positioned(
            top:
                AqwamSpacing.onboardingVisualTop +
                AqwamSpacing.onboardingStarTop,
            left: 0,
            right: 0,
            child: ExcludeSemantics(
              child: SvgPicture.asset(
                AssetsManager.onboardingWelcomeStar,
                width: AqwamSize.w48,
                height: AqwamSize.h48,
                colorFilter: ColorFilter.mode(
                  colors.primary,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          Positioned(
            top:
                AqwamSpacing.onboardingVisualTop +
                AqwamSpacing.onboardingTitleTop,
            left: 0,
            right: 0,
            child: Text(
              localizations.appTitle,
              textAlign: TextAlign.center,
              style: theme.textTheme.displaySmall,
            ),
          ),
          Positioned(
            top:
                AqwamSpacing.onboardingVisualTop +
                AqwamSpacing.onboardingTaglineTop,
            left: 0,
            right: 0,
            child: Text(
              localizations.onboardingWelcomeTagline,
              textAlign: TextAlign.center,
              style: theme.textTheme.labelSmall?.copyWith(
                color: colors.textSecondary,
                fontSize: AqwamFontSize.f10,
                height: AqwamLineHeight.lh1d6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

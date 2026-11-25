import 'package:aqwam/core/assets/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/theme/aqwam_tokens.dart';

class NotificationsScreenWidget extends StatelessWidget {
  const NotificationsScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.extension<AqwamColors>()!;
    final localizations = AppLocalizations.of(context);

    return SizedBox.expand(
      child: Stack(
        children: [
          Positioned(
            top: AqwamSpacing.onboardingNotificationsIconTop,
            left: 0,
            right: 0,
            child: ExcludeSemantics(
              child: SvgPicture.asset(
                AssetsManager.onboardingNotificationsIcon,
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
            top: AqwamSpacing.onboardingNotificationsTitleTop,
            left: 0,
            right: 0,
            child: Text(
              localizations.onboardingNotificationsTitle,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleLarge,
            ),
          ),
          Positioned(
            top: AqwamSpacing.onboardingNotificationsDescriptionTop,
            left: 0,
            right: 0,
            child: Text(
              localizations.onboardingNotificationsDescription,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: AqwamFontWeight.fw600,
                height: AqwamLineHeight.lh2,
              ),
            ),
          ),
          Positioned(
            top: AqwamSpacing.onboardingNotificationsHintTop,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: AqwamSize.w275,
                height: AqwamSize.h40,
                padding: EdgeInsets.symmetric(
                  horizontal: AqwamSpacing.w12,
                  vertical: AqwamSpacing.h8 + AqwamSpacing.h1,
                ),
                decoration: BoxDecoration(
                  color: colors.surfaceVariant,
                  borderRadius: BorderRadius.circular(AqwamRadius.r12),
                ),
                child: Text(
                  localizations.onboardingExactAlarmHint,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: colors.text,
                    fontSize: AqwamFontSize.f11,
                    height: AqwamLineHeight.lh1d8,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

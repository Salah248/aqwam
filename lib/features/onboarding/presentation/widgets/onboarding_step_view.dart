import 'package:aqwam/core/l10n/app_localizations.dart';
import 'package:aqwam/core/theme/aqwam_tokens.dart';
import 'package:aqwam/core/utils/number_formatter.dart';
import 'package:flutter/material.dart';

class OnboardingStepView extends StatelessWidget {
  const OnboardingStepView({
    this.currentStep = 0,
    this.stepCount = 3,
    super.key,
  });

  final int currentStep;
  final int stepCount;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AqwamColors>()!;
    final localizations = AppLocalizations.of(context);
    final languageCode = Localizations.localeOf(context).languageCode;
    final activeStep = currentStep.clamp(0, stepCount - 1);

    return Semantics(
      container: true,
      label: localizations.onboardingStepProgress(
        formatInt(activeStep + 1, languageCode: languageCode),
        formatInt(stepCount, languageCode: languageCode),
      ),
      child: SizedBox(
        width: AqwamSize.w328,
        height: AqwamSpacing.h16,
        child: Align(
          alignment: AlignmentDirectional.topCenter,
          child: _progressDots(
            activeStep: activeStep,
            colors: colors,
          ),
        ),
      ),
    );
  }

  Widget _progressDots({
    required int activeStep,
    required AqwamColors colors,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      textDirection: TextDirection.rtl,
      children: List<Widget>.generate(stepCount, (index) {
        final isActive = index == activeStep;
        return Padding(
          padding: EdgeInsetsDirectional.only(
            end: index == stepCount - 1 ? 0 : AqwamSize.w6,
          ),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: isActive ? colors.primary : colors.divider,
              borderRadius: BorderRadius.circular(AqwamRadius.r6),
            ),
            child: SizedBox(
              width: isActive ? AqwamSize.w18 : AqwamSize.w6,
              height: AqwamSize.h8,
            ),
          ),
        );
      }),
    );
  }
}

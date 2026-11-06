// Onboarding step widget placeholder.
import 'package:flutter/material.dart';

class OnboardingStepView extends StatelessWidget {
  const OnboardingStepView({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      textDirection: Directionality.of(context),
    );
  }
}

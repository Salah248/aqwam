import 'package:aqwam/core/widgets/custom_elevated_button.dart';
import 'package:aqwam/features/onboarding/presentation/widgets/onboarding_step_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/location_screen_widget.dart';
import '../widgets/notifications_screen_widget.dart';
import '../widgets/skip_widget.dart';
import '../widgets/welcome_screen_widget.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int _currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(actions: const [SkipWidget()]),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 364.5.h,
              width: double.maxFinite,
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (value) =>
                    setState(() => _currentPageIndex = value),
                controller: PageController(initialPage: _currentPageIndex),
                children: const [
                  WelcomeScreenWidget(),
                  LocationScreenWidget(),
                  NotificationsScreenWidget(),
                ],
              ),
            ),
            SizedBox(
              height: 372.5.h,
              width: double.maxFinite,
              child: Column(
                children: [
                  const OnboardingStepView(),
                  SizedBox(height: 18.h),
                  const CustomElevatedButton(text: ''),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:aqwam/core/widgets/custom_elevated_button.dart';
import 'package:aqwam/core/widgets/custom_outlined_button.dart';
import 'package:aqwam/features/onboarding/presentation/widgets/onboarding_step_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/platform/location_permission.dart';
import '../../../../core/platform/notification_permission.dart';
import '../../../../core/errors/result.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/aqwam_tokens.dart';
import '../widgets/location_screen_widget.dart';
import '../widgets/notifications_screen_widget.dart';
import '../widgets/skip_widget.dart';
import '../widgets/welcome_screen_widget.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({
    required this.locationPermission,
    required this.notificationPermission,
    super.key,
  });

  final LocationPermissionGateway locationPermission;
  final NotificationPermissionGateway notificationPermission;

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int _currentPageIndex = 0;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToNextPage() {
    if (_currentPageIndex < 2) {
      _pageController.nextPage(
        duration: AqwamMotion.sheetDuration,
        curve: AqwamMotion.sheetCurve,
      );
    }
  }

  void _finishOnboarding() {
    if (mounted) {
      context.go(AppRoutes.home);
    }
  }

  Future<void> _allowNotifications() async {
    final result = await widget.notificationPermission.request();
    if (!mounted) return;
    if (result case Err()) {
      _showPermissionError();
      return;
    }
    _finishOnboarding();
  }

  Future<void> _allowLocation() async {
    final result = await widget.locationPermission.request();
    if (!mounted) return;
    if (result case Err()) {
      _showPermissionError();
      return;
    }
    _goToNextPage();
  }

  void _showPermissionError() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AppLocalizations.of(context).onboardingPermissionError),
      ),
    );
  }

  Future<void> _chooseCityManually() async {
    final confirmed = await context.push<bool>(AppRoutes.cityPicker);
    if (!mounted || confirmed != true) return;
    _goToNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        actions: [
          SkipWidget(onPressed: _finishOnboarding),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 3645,
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (value) =>
                    setState(() => _currentPageIndex = value),
                controller: _pageController,
                children: const [
                  WelcomeScreenWidget(),
                  LocationScreenWidget(),
                  NotificationsScreenWidget(),
                ],
              ),
            ),
            Expanded(
              flex: 3725,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsetsDirectional.symmetric(
                    horizontal: AqwamSpacing.w16,
                  ),
                  child: Column(
                    children: [
                      OnboardingStepView(currentStep: _currentPageIndex),
                      SizedBox(
                        height: AqwamSpacing.h16 + AqwamSize.h8,
                      ),
                      if (_currentPageIndex == 0)
                        CustomElevatedButton(
                          text: localizations.onboardingStart,
                          onPressed: _goToNextPage,
                        )
                      else
                        _currentPageIndex == 1
                            ? _buildLocationActions(localizations)
                            : _buildNotificationActions(localizations),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationActions(AppLocalizations localizations) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CustomElevatedButton(
          text: localizations.onboardingAllowLocation,
          onPressed: _allowLocation,
        ),
        SizedBox(height: AqwamSize.h8),
        CustomOutlinedButton(
          text: localizations.onboardingChooseCityManually,
          onPressed: _chooseCityManually,
        ),
      ],
    );
  }

  Widget _buildNotificationActions(AppLocalizations localizations) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CustomElevatedButton(
          text: localizations.onboardingAllowNotifications,
          onPressed: _allowNotifications,
        ),
        SizedBox(height: AqwamSize.h8),
        CustomOutlinedButton(
          text: localizations.onboardingLater,
          onPressed: _finishOnboarding,
        ),
      ],
    );
  }
}

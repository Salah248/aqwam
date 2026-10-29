import 'package:go_router/go_router.dart';

import 'package:aqwam/app/shell_page.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'shell',
      builder: (context, state) => const ShellPage(),
    ),
  ],
);

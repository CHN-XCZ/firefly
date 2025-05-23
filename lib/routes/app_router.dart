import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../pages/home_page.dart';
import '../pages/user_page.dart';
import '../pages/widgets/custom_bottom_navbar.dart';
import '../providers/app_providers.dart';

final _shellNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(initialLocation: '/home', routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        final path = state.uri.path;
        final index = _resolveTabIndex(path);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ref.read(bottomNavIndexProvider.notifier).state = index;
        });
        return MainScaffold(child: child); // 统一底部导航栏
      },
      routes: [
        GoRoute(
          path: '/home',
          name: 'home',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: HomePage(),
          ),
        ),
        GoRoute(
          path: '/search',
          name: 'search',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: UserPage(),
          ),
        ),
      ],
    ),
    GoRoute(path: '/user', builder: (_, __) => const UserPage()),
  ]);
});

int _resolveTabIndex(String path) {
  if (path.startsWith('/home')) return 0;
  if (path.startsWith('/search')) return 1;
  return 0;
}

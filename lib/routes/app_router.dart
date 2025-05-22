import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../pages/home_page.dart';
import '../pages/user_page.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    routes: [
      GoRoute(path: '/', builder: (_, __) => const HomePage()),
      // GoRoute(path: '/', builder: (_, __) => const UserPage()),
      GoRoute(path: '/user', builder: (_, __) => const UserPage()),
    ],
  );
});

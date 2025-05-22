import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/app_providers.dart';
import 'routes/app_router.dart';
import 'theme/app_theme.dart';
import 'theme/theme_provider.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final splashReady = ref.watch(splashGateProvider); // 新 provider
    
    return splashReady.when(
      loading: () => const MaterialApp(
        home: SplashPage(), // 可用 Logo 页面替代
      ),
      error: (e, _) => MaterialApp(
        home: Scaffold(body: Center(child: Text('启动失败: $e'))),
      ),
      data: (_) {
        final themeMode = ref.watch(themeModeProvider);
        final router = ref.watch(routerProvider);

        return MaterialApp.router(
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: themeMode,
          routerConfig: router,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          '欢迎使用 MyApp',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

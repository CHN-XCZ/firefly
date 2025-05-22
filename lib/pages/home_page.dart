import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/app_providers.dart';
import 'package:go_router/go_router.dart';

import '../theme/theme_provider.dart';
import 'widgets/flexible_app_bar.dart';
import 'widgets/flexible_scaffold.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(counterProvider);
    final themeMode = ref.watch(themeModeProvider);
    return FlexibleScaffold(
      appBar: ImprovisationAppBar(
        ref: ref,
        title: '首页',
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Counter: $count'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => ref.read(counterProvider.notifier).increment(),
              child: const Text('Increment'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => {
                context.push('/user') // 跳转到 UserPage
              }, // 保留当前页，并压入新页面
              child: const Text('Go to User Page'),
            ),
            const SizedBox(height: 16),
            DropdownButton<ThemeMode>(
              value: themeMode,
              onChanged: (ThemeMode? mode) {
                if (mode != null) {
                  ref.read(themeModeProvider.notifier).setTheme(mode);
                }
              },
              items: const [
                DropdownMenuItem(
                  value: ThemeMode.light,
                  child: Text('浅色模式'),
                ),
                DropdownMenuItem(
                  value: ThemeMode.dark,
                  child: Text('暗黑模式'),
                ),
                DropdownMenuItem(
                  value: ThemeMode.system,
                  child: Text('跟随系统'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

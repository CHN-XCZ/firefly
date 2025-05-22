import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../providers/app_providers.dart';
import 'widgets/flexible_app_bar.dart';
import 'widgets/flexible_scaffold.dart';

class UserPage extends HookConsumerWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userProvider);

    final scrollController = useScrollController(); // ✅ 持久且自动释放

    return userAsync.when(
      data: (user) {
        return FlexibleScaffold(
          appBar: SImprovisationAppBar(
            scrollController: scrollController,
            ref: ref,
            title: '你好',
            scrollTriggerOffset: 30,
          ),
          body: ListView(
            controller: scrollController,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 40,
            ),
            children: [
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(16),
                child: Text('Name: ${user.name}'),
              ),
              Text('Email: ${user.email}'),
              for (int i = 0; i < 50; i++)
                Text('Email: ${user.email} $i'),
            ],
          ),
        );
      },
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (e, st) => Scaffold(
        body: Center(child: Text('Error: $e')),
      ),
    );
  }
}

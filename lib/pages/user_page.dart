import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/app_providers.dart';
import 'widgets/flexible_app_bar.dart';
import 'widgets/flexible_scaffold.dart';

class UserPage extends ConsumerWidget {
  const UserPage({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userProvider);

    return userAsync.when(
      data: (user) {
        final scrollController = ScrollController();

        return FlexibleScaffold(
          appBar: FlexibleAppBar(
            scrollController: scrollController,
            title: "你好",
            backgroundColor: Colors.white,
            initialBackgroundColor: Colors.transparent,
            scrollTriggerOffset: 100,
            showBackButton: true,
            onBack: () => Navigator.pop(context),
          ),
          body: Container(
            color: Colors.pink,
            child: ListView(
              controller: scrollController,
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).padding.top + 40),
              children: [
                Container(
                    color: Colors.white, child: Text('Name: ${user.name}')),
                Text('Email: ${user.email}'),
                for (int i = 0; i < 50; i++) Text('Email: ${user.email} $i'),
              ],
            ),
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

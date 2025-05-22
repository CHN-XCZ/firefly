import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../base/LifecycleAwareFlexibleAppBar.dart';
import '../../providers/app_providers.dart';

class SImprovisationAppBar extends LifecycleAwareFlexibleAppBar {
  final WidgetRef ref;

  const SImprovisationAppBar({
    super.key,
    required this.ref,
    required super.scrollController,
    required super.title,
    super.scrollTriggerOffset,
    super.initialBackgroundColor,
  }) : super(enableScrollListener: true);

  @override
  void onScrollStateChanged(bool isScrolled) {
    ref.read(appBarScrolledProvider.notifier).state = isScrolled;
    // 设置title
  }
}

class ImprovisationAppBar extends LifecycleAwareFlexibleAppBar {
  final WidgetRef ref;

  const ImprovisationAppBar({
    super.key,
    required this.ref,
    required super.title,
    super.initialBackgroundColor,
  }) : super(showBackButton: false);
}

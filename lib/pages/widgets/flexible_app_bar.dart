import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../base/LifecycleAwareFlexibleAppBar.dart';
import '../../providers/app_providers.dart';

/// 这个类是一个自定义的AppBar，继承自LifecycleAwareFlexibleAppBar,会根据滑动状态来改变AppBar的颜色和标题
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

/// 这个类是一个自定义的AppBar，继承自LifecycleAwareFlexibleAppBar,他不会根据滑动状态来改变AppBar的颜色和标题
class ImprovisationAppBar extends LifecycleAwareFlexibleAppBar {
  final WidgetRef ref;

  const ImprovisationAppBar({
    super.key,
    required this.ref,
    required super.title,
    super.initialBackgroundColor,
  }) : super(showBackButton: false);
}

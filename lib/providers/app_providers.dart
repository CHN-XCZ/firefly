import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user.dart';
import '../services/api_service.dart';
import '../theme/theme_provider.dart';

// 计数器 StateNotifier
final counterProvider = StateNotifierProvider<CounterNotifier, int>((ref) {
  return CounterNotifier();
});

class CounterNotifier extends StateNotifier<int> {
  CounterNotifier() : super(0);
  void increment() => state++;
}

final appBarHeight = StateNotifierProvider<AppBarNotifier, double>((ref) {
  return AppBarNotifier();
});

class AppBarNotifier extends StateNotifier<double> {
  AppBarNotifier() : super(0);

  void setAppBarHeight(double height) {
    state = height;
  }
}

//* AppBar 滚动状态
final appBarScrolledProvider = StateProvider<bool>((ref) => false);

// 异步请求用户信息
final userProvider = FutureProvider<User>((ref) async {
  final api = ApiService();
  return api.fetchUser();
});

final splashGateProvider = FutureProvider<bool>((ref) async {
  // 等待主题加载完成
  final notifier = ref.read(themeModeProvider.notifier);
  await notifier.loadTheme();

  // 固定等待 2 秒（可自定义）
  await Future.delayed(const Duration(seconds: 0));

  return true; // 表示初始化 + 延迟完成
});

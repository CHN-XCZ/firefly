import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'providers/app_providers.dart';
import 'routes/app_router.dart';
import 'theme/app_theme.dart';
import 'theme/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown, // 如不想支持倒置可删掉这行
  ]);
  runApp(const ProviderScope(child: MyApp()));
}

/// 用 ScreenUtilInit 包一层，其他保持不变
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        final splashReady = ref.watch(splashGateProvider);
        return splashReady.when(
          loading: () => const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: SplashPage(),
          ),
          error: (e, _) => MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(child: Text('启动失败: $e')),
            ),
          ),
          data: (_) {
            final themeMode = ref.watch(themeModeProvider);
            final router = ref.watch(routerProvider);
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              theme: AppTheme.light,
              darkTheme: AppTheme.dark,
              themeMode: themeMode,
              routerConfig: router,
              builder: (context, widget) {
                ScreenUtil.init(context);
                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                  child: widget!,
                );
              },
            );
          },
        );
      },

      // child 是在初始化完成后传给 builder 的根 widget
      child: const SizedBox.shrink(),
    );
  }
}

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
            Text('欢迎使用 MyApp', style: TextStyle(fontSize: 24.sp)), // 用 .sp 适配字体
      ),
    );
  }
}

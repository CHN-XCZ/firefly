import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config.dart';
import '../../providers/app_providers.dart';
import '../../theme/app_theme.dart';

class CustomBottomNavBar extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(bottomNavIndexProvider);
    final notifier = ref.read(bottomNavIndexProvider.notifier);
    final customTheme = getCustomTheme(context);
    final backgroundColor = Theme.of(context).primaryColor.withOpacity(0.6);
    final tabs = [
      {'icon': Icons.home, 'label': '首页', 'path': '/home'},
      {'icon': Icons.search, 'label': '搜索', 'path': '/search'},
      // {'icon': Icons.person, 'label': '我的', 'path': '/profile'},
    ];
    final double statusBarHeight = MediaQuery.of(context).padding.bottom;
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 50.0, sigmaY: 50.0),
        child: Container(
          height: statusBarHeight + kBottomBarHeight,
          padding: EdgeInsets.only(bottom: statusBarHeight),
          decoration: BoxDecoration(
              color: backgroundColor,
              border: Border(
                  top: BorderSide(color: customTheme.borderColor, width: 0.4))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(tabs.length, (i) {
              final isActive = i == index;
              return Expanded(
                flex: 1, // 每项等宽
                child: GestureDetector(
                  onTap: () async {
                    notifier.state = i;
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setInt('last_tab', i);
                    // ignore: use_build_context_synchronously
                    context.go(tabs[i]['path'] as String);
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(tabs[i]['icon'] as IconData,
                            color: isActive ? Colors.blue : Colors.grey),
                        Text(tabs[i]['label'] as String,
                            style: TextStyle(
                              color: isActive ? Colors.blue : Colors.grey,
                              fontSize: 12.sp,
                            )),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class MainScaffold extends StatelessWidget {
  final Widget child;

  const MainScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: child),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CustomBottomNavBar(),
          ),
        ],
      ),
    );
  }
}

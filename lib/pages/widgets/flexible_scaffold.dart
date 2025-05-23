import 'package:flutter/material.dart';

/// 它是一个灵活的Scaffold组件，可以根据需要自定义AppBar和Body
class FlexibleScaffold extends StatelessWidget {
  final Widget body;
  final Widget? appBar;

  const FlexibleScaffold({
    super.key,
    required this.body,
    this.appBar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: body),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: appBar != null ? appBar! : const SizedBox(),
          ),
        ],
      ),
    );
  }
}

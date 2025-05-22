import 'package:flutter/material.dart';

class FlexibleScaffold extends StatelessWidget {
  final Widget body;
  final Widget appBar;

  const FlexibleScaffold({
    super.key,
    required this.body,
    required this.appBar,
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
            child: appBar,
          ),
        ],
      ),
    );
  }
}

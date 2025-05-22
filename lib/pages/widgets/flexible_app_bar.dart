import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FlexibleAppBar extends StatefulWidget {
  final ScrollController scrollController;
  final double height;
  final String title;
  final Color backgroundColor;
  final Color initialBackgroundColor;
  final double scrollTriggerOffset;
  final bool showBackButton;
  final VoidCallback? onBack;
  final List<Widget>? actions;

  const FlexibleAppBar({
    super.key,
    required this.scrollController,
    this.height = 80,
    this.title = '',
    this.backgroundColor = Colors.white,
    this.initialBackgroundColor = Colors.transparent,
    this.scrollTriggerOffset = 100,
    this.showBackButton = true,
    this.onBack,
    this.actions,
  });

  @override
  State<FlexibleAppBar> createState() => _FlexibleAppBarState();
}

class _FlexibleAppBarState extends State<FlexibleAppBar> {
  late ValueNotifier<bool> _scrolled;

  @override
  void initState() {
    super.initState();
    _scrolled = ValueNotifier(false);
    widget.scrollController.addListener(_handleScroll);
  }

  void _handleScroll() {
    final isScrolled =
        widget.scrollController.offset >= widget.scrollTriggerOffset;
    if (_scrolled.value != isScrolled) {
      _scrolled.value = isScrolled;
    }
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_handleScroll);
    _scrolled.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return ValueListenableBuilder(
      valueListenable: _scrolled,
      builder: (context, bool isScrolled, _) {
        return Container(
          height: 40 + statusBarHeight,
          padding: EdgeInsets.only(top: statusBarHeight, left: 16, right: 16),
          decoration: BoxDecoration(
            color: isScrolled
                ? widget.backgroundColor
                : widget.initialBackgroundColor,
            boxShadow: isScrolled
                ? [const BoxShadow(color: Colors.black12, blurRadius: 4)]
                : [],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (widget.showBackButton)
                IconButton(
                  color: Colors.amber,
                  icon: Icon(
                    CupertinoIcons.chevron_back,
                    color: isScrolled ? Colors.black : Colors.white,
                  ),
                  onPressed: widget.onBack ??
                      () {
                        Navigator.of(context).maybePop();
                      },
                ),
              Expanded(
                child: Center(
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 18,
                      color: isScrolled ? Colors.black : Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              if (widget.actions != null)
                Row(children: widget.actions!)
              else
                const SizedBox(width: 48), // 占位右侧按钮
            ],
          ),
        );
      },
    );
  }
}

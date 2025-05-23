// ignore_for_file: deprecated_member_use

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../config.dart';
import '../theme/app_theme.dart';

abstract class LifecycleAwareFlexibleAppBar extends StatefulWidget {
  final ScrollController? scrollController;
  final double height;
  final String title;
  final Color initialBackgroundColor;
  final double scrollTriggerOffset;
  final bool showBackButton;
  final VoidCallback? onBack;
  final List<Widget>? actions;
  final bool enableScrollListener;

  const LifecycleAwareFlexibleAppBar({
    super.key,
    this.scrollController,
    this.height = 80,
    this.title = '',
    this.initialBackgroundColor = Colors.transparent,
    this.scrollTriggerOffset = 100,
    this.showBackButton = true,
    this.onBack,
    this.actions,
    this.enableScrollListener = false,
  }) : assert(
          !enableScrollListener || scrollController != null,
          'scrollController is required when enableScrollListener is true',
        );

  @override
  State<StatefulWidget> createState() => _LifecycleAwareFlexibleAppBarState();

  // 子类可以 override
  void onScrollStateChanged(bool isScrolled) {}
}

class _LifecycleAwareFlexibleAppBarState
    extends State<LifecycleAwareFlexibleAppBar> with WidgetsBindingObserver {
  late ValueNotifier<bool> _scrolled;

  @override
  void initState() {
    super.initState();
    _scrolled = ValueNotifier(false);
    if (widget.enableScrollListener) {
      widget.scrollController?.addListener(_handleScroll);
    }
    WidgetsBinding.instance.addObserver(this);

    // 首帧触发一次判断
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.enableScrollListener) {
        _handleScroll();
      }
    });
  }

  @override
  void dispose() {
    if (widget.enableScrollListener) {
      widget.scrollController?.removeListener(_handleScroll);
    }
    _scrolled.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _handleScroll(); // 回到前台时重新检测
    }
  }

  void _handleScroll() {
    if (widget.scrollController == null) return;
    final isScrolled =
        widget.scrollController!.offset >= widget.scrollTriggerOffset;
    if (_scrolled.value != isScrolled) {
      _scrolled.value = isScrolled;
      widget.onScrollStateChanged(isScrolled);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final customTheme = getCustomTheme(context);
    final backgroundColor = Theme.of(context).primaryColor.withOpacity(0.6);
    return ValueListenableBuilder(
      valueListenable: _scrolled,
      builder: (context, bool isScrolled, _) {
        return ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(
                sigmaX: (isScrolled | !widget.enableScrollListener) ? 50.0 : 0,
                sigmaY: (isScrolled | !widget.enableScrollListener) ? 50.0 : 0),
            child: Container(
              height: statusBarHeight + kAppBarHeight,
              padding: EdgeInsets.only(
                top: statusBarHeight,
              ),
              decoration: BoxDecoration(
                color: ((isScrolled | !widget.enableScrollListener)
                    ? backgroundColor
                    : widget.initialBackgroundColor), // 半透明
                border: Border(
                  bottom: BorderSide(
                    color: (isScrolled | !widget.enableScrollListener)
                        ? customTheme.borderColor
                        : Colors.transparent,
                    width:
                        (isScrolled | !widget.enableScrollListener) ? 0.4 : 0,
                  ),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  (widget.showBackButton)
                      ? IconButton(
                          icon: Icon(
                            size: 20,
                            CupertinoIcons.chevron_left,
                            color: (isScrolled | !widget.enableScrollListener)
                                ? Colors.black
                                : Colors.white,
                          ),
                          onPressed:
                              widget.onBack ?? () => Navigator.pop(context),
                        )
                      : const SizedBox(width: 48),
                  Expanded(
                    child: Center(
                      child: Text(
                        (isScrolled | !widget.enableScrollListener)
                            ? widget.title
                            : '',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  if (widget.actions != null)
                    Row(children: widget.actions!)
                  else
                    const SizedBox(width: 48),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

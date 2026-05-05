import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// A widget that scrolls text horizontally if it overflows, triggered by hover or selection.
class MarqueeText extends StatefulWidget {
  final String text;
  final TextStyle style;
  final bool isHovered;
  final bool isSelected;

  const MarqueeText({
    super.key,
    required this.text,
    required this.style,
    this.isHovered = false,
    this.isSelected = false,
  });

  @override
  State<MarqueeText> createState() => _MarqueeTextState();
}

class _MarqueeTextState extends State<MarqueeText> {
  late ScrollController _scrollController;
  Timer? _timer;
  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkAnimation());
  }

  @override
  void didUpdateWidget(MarqueeText oldWidget) {
    super.didUpdateWidget(oldWidget);
    // If text or style changed, we might need to reset or recheck
    if (oldWidget.text != widget.text || oldWidget.style != widget.style) {
      _stopScrolling();
      WidgetsBinding.instance.addPostFrameCallback((_) => _checkAnimation());
    } else {
      _checkAnimation();
    }
  }

  void _checkAnimation() {
    if (!mounted) return;
    
    final bool isMobile = defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.android;

    // On web/desktop, animate on hover. On mobile, animate if selected.
    bool shouldAnimate = widget.isHovered || (isMobile && widget.isSelected);

    if (shouldAnimate && !_isAnimating) {
      _startScrolling();
    } else if (!shouldAnimate && _isAnimating) {
      _stopScrolling();
    }
  }

  void _startScrolling() {
    if (!_scrollController.hasClients) return;
    
    // Check if it actually overflows
    final maxScroll = _scrollController.position.maxScrollExtent;
    if (maxScroll <= 0) return;

    _isAnimating = true;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(milliseconds: 40), (timer) {
      if (_scrollController.hasClients) {
        final max = _scrollController.position.maxScrollExtent;
        if (max <= 0) {
          _stopScrolling();
          return;
        }

        double next = _scrollController.offset + 1.0;
        if (next >= max) {
          // Pause at the end for a moment before jumping back
          _timer?.cancel();
          Future.delayed(const Duration(seconds: 1), () {
            if (mounted && _isAnimating) {
              _scrollController.animateTo(
                0,
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeOut,
              );
              Future.delayed(const Duration(milliseconds: 700), () {
                if (mounted && _isAnimating) _startScrolling();
              });
            }
          });
        } else {
          _scrollController.jumpTo(next);
        }
      }
    });
  }

  void _stopScrolling() {
    _isAnimating = false;
    _timer?.cancel();
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      child: Text(
        widget.text,
        style: widget.style,
        maxLines: 1,
        overflow: TextOverflow.visible,
      ),
    );
  }
}

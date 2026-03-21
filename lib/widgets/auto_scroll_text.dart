import 'dart:async';
import 'package:flutter/material.dart';

class AutoScrollText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final double velocity; // pixels per second
  final Duration pauseDuration;

  const AutoScrollText(
    this.text, {
    super.key,
    this.style,
    this.velocity = 50.0,
    this.pauseDuration = const Duration(seconds: 2),
  });

  @override
  State<AutoScrollText> createState() => _AutoScrollTextState();
}

class _AutoScrollTextState extends State<AutoScrollText> {
  final ScrollController _scrollController = ScrollController();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startScrolling();
    });
  }

  @override
  void didUpdateWidget(covariant AutoScrollText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text) {
      _resetAndScroll();
    }
  }

  void _resetAndScroll() {
    _timer?.cancel();
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(0.0);
    }
    _startScrolling();
  }

  void _startScrolling() async {
    _timer?.cancel();
    _timer = Timer(widget.pauseDuration, () async {
      if (!mounted || !_scrollController.hasClients) return;
      
      double maxScroll = _scrollController.position.maxScrollExtent;
      if (maxScroll > 0) {
        
        int durationMs = (maxScroll / widget.velocity * 1000).toInt();
        
        await _scrollController.animateTo(
          maxScroll,
          duration: Duration(milliseconds: durationMs),
          curve: Curves.linear,
        );
        
        if (!mounted) return;
        
        _timer = Timer(widget.pauseDuration, () {
          if (!mounted || !_scrollController.hasClients) return;
          _scrollController.jumpTo(0.0);
          _startScrolling();
        });
      }
    });
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
      ),
    );
  }
}

import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';

class AudioVisualizerWidget extends StatefulWidget {
  final double currentPosition;
  final double totalDuration;
  final Color color;
  final bool isPlaying;

  const AudioVisualizerWidget({
    super.key,
    required this.currentPosition,
    required this.totalDuration,
    required this.color,
    required this.isPlaying,
  });

  @override
  State<AudioVisualizerWidget> createState() => _AudioVisualizerWidgetState();
}

class _AudioVisualizerWidgetState extends State<AudioVisualizerWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final Random _random = Random();
  List<double> _barHeights = [];
  final int _barCount = 80;

  @override
  void initState() {
    super.initState();
    _initializeBarHeights();

    _animationController = AnimationController(
      vsync: this,
      duration:
          const Duration(milliseconds: 100), // Faster update for smoother look
    )..addListener(() {
        if (widget.isPlaying) {
          setState(() {
            _updateBarHeights();
          });
        }
      });

    if (widget.isPlaying) {
      _animationController.repeat();
    }
  }

  void _initializeBarHeights() {
    // Generate a smooth curve initially
    _barHeights = List.generate(_barCount, (index) {
      // Create a wave-like pattern
      double x = index / _barCount * 4 * pi;
      return (sin(x) + 1) / 2 * 0.5 + 0.2;
    });
  }

  void _updateBarHeights() {
    // Smoother transitions
    List<double> nextHeights = List.generate(_barCount, (index) {
      // Base wave
      double x =
          (index / _barCount * 4 * pi) + (_animationController.value * 2 * pi);
      double flow = (sin(x) + 1) / 2;

      // Add random jitter
      double jitter = _random.nextDouble() * 0.4;

      // Combine
      return (flow * 0.6 + jitter * 0.4) * 0.9 + 0.1;
    });

    // Lerp towards next heights for smoothness (simple low-pass filter)
    for (int i = 0; i < _barCount; i++) {
      _barHeights[i] =
          lerpDouble(_barHeights[i], nextHeights[i], 0.3) ?? nextHeights[i];
    }
  }

  @override
  void didUpdateWidget(AudioVisualizerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isPlaying != oldWidget.isPlaying) {
      if (widget.isPlaying) {
        _animationController.repeat();
      } else {
        _animationController.stop();
        // Optional: Animate to flat or keep last state
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  String _formatDuration(double seconds) {
    if (seconds.isNaN || seconds.isInfinite) return "0:00";
    final duration = Duration(seconds: seconds.toInt());
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final secs = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$secs';
  }

  @override
  Widget build(BuildContext context) {
    final progress = (widget.totalDuration > 0)
        ? widget.currentPosition / widget.totalDuration
        : 0.0;

    return Column(
      children: [
        // Visualizer Canvas
        SizedBox(
          height: 120, // Taller visualizer
          width: double.infinity,
          child: CustomPaint(
            painter: VisualizerPainter(
              barHeights: _barHeights,
              color: widget.color,
              progress: progress,
            ),
          ),
        ),

        const SizedBox(height: 8),

        // Time labels
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _formatDuration(widget.currentPosition),
                style: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                  fontSize: 12,
                  fontFamily: 'monospace',
                ),
              ),
              Text(
                _formatDuration(widget.totalDuration),
                style: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                  fontSize: 12,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class VisualizerPainter extends CustomPainter {
  final List<double> barHeights;
  final Color color;
  final double progress;

  VisualizerPainter({
    required this.barHeights,
    required this.color,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;

    final barWidth = size.width / barHeights.length;
    // Add small gap
    final gap = barWidth * 0.2;
    final drawWidth = barWidth - gap;

    // Draw mirrored spectrum for PowerAmp feel
    for (int i = 0; i < barHeights.length; i++) {
      final x = i * barWidth + gap / 2;
      final height = barHeights[i] * size.height;
      final centerY = size.height / 2;

      // Top bar
      final topRect = RRect.fromRectAndRadius(
        Rect.fromLTWH(x, centerY - height / 2, drawWidth, height),
        const Radius.circular(2),
      );

      // Determine color based on progress
      final barProgress = i / barHeights.length;
      if (barProgress <= progress) {
        paint.shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            color.withOpacity(0.4),
            color,
            color.withOpacity(0.4),
          ],
        ).createShader(
            Rect.fromLTWH(x, centerY - height / 2, drawWidth, height));
      } else {
        paint.shader = null;
        paint.color = Colors.white.withOpacity(0.15);
      }

      canvas.drawRRect(topRect, paint);
    }
  }

  @override
  bool shouldRepaint(covariant VisualizerPainter oldDelegate) {
    return oldDelegate.barHeights != barHeights ||
        oldDelegate.progress != progress ||
        oldDelegate.color != color;
  }
}

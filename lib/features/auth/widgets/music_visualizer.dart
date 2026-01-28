import 'dart:math';
import 'package:flutter/material.dart';

class MusicVisualizer extends StatefulWidget {
  final int barCount;
  final double width;
  final double height;
  final bool showDots;

  const MusicVisualizer({
    super.key,
    this.barCount = 11,
    this.width = 160,
    this.height = 100,
    this.showDots = true,
  });

  @override
  State<MusicVisualizer> createState() => _MusicVisualizerState();
}

class _MusicVisualizerState extends State<MusicVisualizer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Random _random = Random();
  late List<double> _heights;
  late List<Offset> _dots;

  @override
  void initState() {
    super.initState();
    _heights = List.generate(widget.barCount, (index) => _random.nextDouble());
    _dots = List.generate(
        10,
        (index) => Offset(_random.nextDouble() * widget.width,
            _random.nextDouble() * widget.height));

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..addListener(() {
        setState(() {
          for (int i = 0; i < widget.barCount; i++) {
            // Symmetrical wave pattern peaking at the center bar (index 5 for count 11)
            int centerIndex = widget.barCount ~/ 2;
            double distanceToCenter = (i - centerIndex).abs().toDouble();
            double factor = 1.0 - (distanceToCenter / centerIndex);

            double wave =
                (sin(_controller.value * 2 * pi + i * 0.8).abs() * 0.5) + 0.5;
            _heights[i] = 0.2 + (wave * factor * 0.8);
          }

          // Animate dots slightly
          for (int i = 0; i < _dots.length; i++) {
            _dots[i] = Offset(
              (_dots[i].dx + 0.2) % widget.width,
              (_dots[i].dy + _random.nextDouble() * 0.2 - 0.1) % widget.height,
            );
          }
        });
      });

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // The Dots (Particles)
        if (widget.showDots)
          ...List.generate(_dots.length, (index) {
            return Positioned(
              left: _dots[index].dx,
              top: _dots[index].dy,
              child: Container(
                width: 2,
                height: 2,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            );
          }),

        // The Visualizer Bars
        SizedBox(
          width: widget.width,
          height: widget.height,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: List.generate(widget.barCount, (index) {
              int centerIndex = widget.barCount ~/ 2;
              bool isCenter = index == centerIndex;

              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 3),
                width: 6,
                height: widget.height *
                    (isCenter ? _heights[index] * 1.5 : _heights[index]),
                decoration: BoxDecoration(
                  gradient: isCenter
                      ? const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFF66FFFF),
                            Color(0xFFE497FF),
                          ],
                        )
                      : const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFF66FFFF),
                            Color(0xFF00BFFF),
                          ],
                        ),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF66FFFF).withOpacity(0.5),
                      blurRadius: 15,
                      spreadRadius: 1,
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}

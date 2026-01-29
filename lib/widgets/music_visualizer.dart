import 'dart:math';
import 'package:flutter/material.dart';

enum VisualizerBarSize {
  xs(0.1),
  s(0.2),
  m(0.3),
  l(0.4),
  xl(0.5),
  axl(0.6),
  bxl(0.7),
  cxl(0.8),
  dxl(0.9);

  final double heightMultiplier;
  const VisualizerBarSize(this.heightMultiplier);
}

class MusicVisualizer extends StatefulWidget {
  final int barCount;
  final double width;
  final double height;
  final bool showDots;
  final Color color;

  const MusicVisualizer({
    super.key,
    this.barCount = 11,
    this.width = 160,
    this.height = 100,
    this.showDots = true,
    this.color = const Color(0xFF66FFFF),
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
              int centerIndex = widget.barCount ~/ 4;
              bool isCenter = index == centerIndex;

              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 3),
                width: 6,
                height: widget.height *
                    (isCenter ? _heights[index] * 1.5 : _heights[index]),
                decoration: BoxDecoration(
                  gradient: isCenter
                      ? LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            widget.color,
                            widget.color.withOpacity(0.5),
                          ],
                        )
                      : LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            widget.color,
                            widget.color.withOpacity(0.5),
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

class MusicVisualizerV2 extends StatefulWidget {
  final List<VisualizerBarSize> barSizes;
  final double width;
  final double height;
  final bool showDots;
  final Color? baseColor;

  const MusicVisualizerV2({
    super.key,
    required this.barSizes,
    this.width = 160,
    this.height = 100,
    this.showDots = true,
    this.baseColor,
  });

  @override
  State<MusicVisualizerV2> createState() => _MusicVisualizerV2State();
}

class _MusicVisualizerV2State extends State<MusicVisualizerV2>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Random _random = Random();
  late List<double> _animOffsets;
  late List<double> _animSpeeds;
  late List<Offset> _dots;

  @override
  void initState() {
    super.initState();
    _animOffsets = List.generate(
      widget.barSizes.length,
      (index) => _random.nextDouble() * 2 * pi,
    );
    _animSpeeds = List.generate(
      widget.barSizes.length,
      (index) => 0.5 + _random.nextDouble() * 1.5,
    );

    // Initialize constant dots
    _dots = List.generate(
      15,
      (index) => Offset(
        _random.nextDouble() * widget.width,
        _random.nextDouble() * widget.height,
      ),
    );

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            if (widget.showDots) _buildDots(),
            SizedBox(
              width: widget.width,
              height: widget.height,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: List.generate(widget.barSizes.length, (index) {
                  final size = widget.barSizes[index];

                  // Individual speed and offset for more organic movement
                  double t = _controller.value * 2 * pi * _animSpeeds[index] +
                      _animOffsets[index];
                  // Oscillate between 0.8 and 1.0 (only 20% decrease)
                  double wave = 0.8 + (sin(t).abs() * 0.2);

                  // Base height is determined by the size enum
                  double targetHeight =
                      widget.height * 0.8 * size.heightMultiplier;
                  double currentHeight = targetHeight * wave;

                  // Clamp height to widget height
                  currentHeight = currentHeight.clamp(4.0, widget.height);

                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    width: 4,
                    height: currentHeight,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: widget.baseColor != null
                            ? [
                                widget.baseColor!,
                                widget.baseColor!.withOpacity(0.5)
                              ]
                            : const [
                                Color(0xFF66FFFF), // Cyan
                                Color(0xFFE497FF), // Purple/Pink
                              ],
                      ),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF66FFFF).withOpacity(0.3),
                          blurRadius: 4,
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
      },
    );
  }

  Widget _buildDots() {
    return CustomPaint(
      size: Size(widget.width, widget.height),
      painter: _DotsPainter(_dots, _controller.value),
    );
  }
}

class _DotsPainter extends CustomPainter {
  final List<Offset> dots;
  final double animationValue;

  _DotsPainter(this.dots, this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withOpacity(0.3);
    for (var dot in dots) {
      // Subtle float animation
      double dy = sin(animationValue * 2 * pi + dot.dx) * 5;
      canvas.drawCircle(
        Offset(dot.dx, dot.dy + dy),
        1.2,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _DotsPainter oldDelegate) => true;
}

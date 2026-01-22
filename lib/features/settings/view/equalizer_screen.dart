import 'package:flutter/material.dart';

class EqualizerScreen extends StatefulWidget {
  const EqualizerScreen({super.key});

  @override
  State<EqualizerScreen> createState() => _EqualizerScreenState();
}

class _EqualizerScreenState extends State<EqualizerScreen> {
  // Mock band values 0.0 to 1.0 (0.5 is flat)
  final List<double> values = [
    0.6,
    0.45,
    0.35,
    0.4,
    0.45,
    0.55,
    0.65,
    0.75,
    0.85,
    0.85
  ];
  final List<String> labels = [
    "32",
    "64",
    "125",
    "250",
    "500",
    "1k",
    "2k",
    "4k",
    "8k",
    "16k"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text("EQUALIZER",
            style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2)),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.cyan),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text("SAVE",
                    style: TextStyle(
                        color: Colors.cyan,
                        fontWeight: FontWeight.bold,
                        fontSize: 12)),
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          // Preset Dropdown
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
                color: const Color(0xFF161B22),
                borderRadius: BorderRadius.circular(24)),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.circle, color: Colors.cyan, size: 8),
                SizedBox(width: 8),
                Text("Preset: ", style: TextStyle(color: Colors.grey)),
                Text("Rock",
                    style: TextStyle(
                        color: Colors.cyan, fontWeight: FontWeight.bold)),
                SizedBox(width: 8),
                Icon(Icons.keyboard_arrow_down, color: Colors.grey, size: 16),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Visualizer Graph Mock
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            height: 160,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFF111418),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white10),
            ),
            child: Stack(
              children: [
                // Grid lines
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildDashLine(),
                    _buildDashLine(),
                    _buildDashLine(),
                  ],
                ),
                const Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Text("+12dB",
                            style:
                                TextStyle(color: Colors.cyan, fontSize: 10)))),
                const Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Text("-12dB",
                            style:
                                TextStyle(color: Colors.cyan, fontSize: 10)))),

                // Curve (Static SVG-like path or simplified Paint)
                CustomPaint(
                  size: const Size(double.infinity, 160),
                  painter: _CurvePainter(),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // Sliders
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: List.generate(10, (index) => _buildSlider(index)),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Bands labels
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                  10,
                  (index) => SizedBox(
                      width: 24,
                      child: Center(
                          child: Text(labels[index],
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 10))))),
            ),
          ),

          const SizedBox(height: 32),

          // Knobs
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildKnob("BASS", 0.35, Colors.cyan),
              _buildKnob("TREBLE", 0.75, Colors.cyanAccent),
            ],
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildSlider(int index) {
    final value = values[index];
    return SizedBox(
      width: 24,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final height = constraints.maxHeight;
          final thumbY = height * (1 - value);
          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              // Track
              Container(
                  width: 4,
                  height: height,
                  decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(2))),
              // Active Track (Center referenced?) Screenshot usually has centered reference but simplistic:
              // Screenshot shows gradients. I'll stick to simple thumb.

              // Thumb
              Positioned(
                top: thumbY - 10,
                child: Container(
                  width: 20,
                  height: 36,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.cyan, width: 2),
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.transparent,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.cyan.withOpacity(0.2), blurRadius: 8)
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildKnob(String label, double value, Color color) {
    return Column(
      children: [
        SizedBox(
          width: 80,
          height: 80,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF161B22),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 4),
                        blurRadius: 8)
                  ],
                ),
              ),
              CircularProgressIndicator(
                  value: 0.75,
                  valueColor: const AlwaysStoppedAnimation(Colors.white10),
                  strokeWidth: 4), // bg arc
              CircularProgressIndicator(
                  value: value * 0.75,
                  valueColor: AlwaysStoppedAnimation(color),
                  strokeWidth: 4,
                  strokeCap: StrokeCap.round), // value arc
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.circle, size: 6, color: color),
                  Text("${(value * 100).toInt()}%",
                      style:
                          TextStyle(color: color, fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Text(label,
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5)),
        const Text("BOOST", style: TextStyle(color: Colors.grey, fontSize: 10)),
      ],
    );
  }

  Widget _buildDashLine() {
    return Container(
        height: 1,
        color: Colors.white10,
        margin: const EdgeInsets.symmetric(vertical: 20)); // simplified
  }
}

class _CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.cyan
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..maskFilter = const MaskFilter.blur(BlurStyle.solid, 4); // glowish

    final path = Path();
    path.moveTo(0, size.height * 0.6);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.9,
        size.width * 0.5, size.height * 0.6);
    path.quadraticBezierTo(
        size.width * 0.75, size.height * 0.3, size.width, size.height * 0.3);

    canvas.drawPath(path, paint);

    // Gradient fill below? Screenshot shows faint glow.
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

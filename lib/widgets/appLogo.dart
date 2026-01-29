import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sonic_snap/widgets/music_visualizer.dart';

Widget buildLogo(BuildContext context) {
  final double screenWidth = MediaQuery.of(context).size.width;
  final bool isLargeScreen = screenWidth > 1200;
    bool isSmallMobile = screenWidth < 450;
    double fontSize = isSmallMobile ? 28 : 56;
    double vizHeight = isSmallMobile ? 80 : 120;
    double vizWidth = isSmallMobile ? 40 : 60;
    // double spacing = isSmallMobile ? 8 : 16;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MusicVisualizerV2(
              barSizes: [
                VisualizerBarSize.xs,
                VisualizerBarSize.m,
                VisualizerBarSize.l,
                VisualizerBarSize.bxl,
                if (isLargeScreen) VisualizerBarSize.dxl,
                if (isLargeScreen) VisualizerBarSize.xl,
                VisualizerBarSize.m,
              ],
              width: vizWidth,
              height: vizHeight,
              showDots: false,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Image.asset(
                "assets/logo/login.png",
                height: fontSize,
              ),
            ),
            MusicVisualizerV2(
              barSizes: [
                VisualizerBarSize.m,
                if (isLargeScreen) VisualizerBarSize.xl,
                if (isLargeScreen) VisualizerBarSize.dxl,
                VisualizerBarSize.bxl,
                VisualizerBarSize.l,
                VisualizerBarSize.m,
                VisualizerBarSize.xs,
              ],
              width: vizWidth,
              height: vizHeight,
              showDots: false,
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          "PLUG INTO THE SOUNDSCAPE",
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontSize: isSmallMobile ? 10 : 16,
                letterSpacing: 3,
                color: Colors.white24,
                fontWeight: FontWeight.w900,
              ),
        ),
      ],
    );
  }
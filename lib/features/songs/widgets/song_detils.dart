import 'package:flutter/material.dart';

class SongDetails extends StatelessWidget {
  final bool showTitle;
  final Map<String, dynamic> song;
  const SongDetails({super.key, required this.song, this.showTitle = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showTitle) ...[
          Text(
            song['title'] ?? "Unknown",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            song['artist'] ?? "Unknown",
            style: const TextStyle(
              color: Color(0xFFB565FF),
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          )
        ],
        const SizedBox(height: 4),
        Text(
          song['album'] ?? "The Fat of the Land",
          style: showTitle
              ? TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 14)
              : const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "AUDIO PROPERTIES",
            style: TextStyle(
              color: Colors.white.withOpacity(0.3),
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            _buildStatBox("BITRATE", "1411", "kbps"),
            const SizedBox(width: 12),
            _buildStatBox("SAMPLE RATE", "44.1", "kHz"),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.04),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.05)),
          ),
          child: IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(child: _buildCompactStat("FILE SIZE", "32.4 MB")),
                VerticalDivider(color: Colors.white.withOpacity(0.1), width: 1),
                Flexible(
                    child: _buildCompactStat(
                        "DURATION", song['duration'] ?? "4:42")),
                VerticalDivider(color: Colors.white.withOpacity(0.1), width: 1),
                Flexible(child: _buildCompactStat("TYPE", "Stereo")),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildStatBox(String label, String value, String unit) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.04),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                color: Colors.white.withOpacity(0.3),
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  unit,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.3),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompactStat(String label, String value) {
    return Column(
      children: [
        Text(label,
            style:
                TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 9)),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

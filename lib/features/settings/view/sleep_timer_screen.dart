import 'package:flutter/material.dart';
import 'dart:math';

class SleepTimerScreen extends StatefulWidget {
  const SleepTimerScreen({super.key});

  @override
  State<SleepTimerScreen> createState() => _SleepTimerScreenState();
}

class _SleepTimerScreenState extends State<SleepTimerScreen> {
  int selectedMinutes = 30;
  bool finishLastSong = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: TextButton(
            onPressed: () {},
            child: const Text("Reset", style: TextStyle(color: Colors.grey))),
        title: const Text("Sleep Timer",
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(
              icon: const Icon(Icons.close, color: Colors.grey),
              onPressed: () => Navigator.pop(context)),
        ],
      ),
      body: Column(
        children: [
          const Spacer(),

          // Circular Slider Mock
          SizedBox(
            height: 300,
            width: 300,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Track
                SizedBox(
                  width: 260,
                  height: 260,
                  child: CircularProgressIndicator(
                    value: 1.0,
                    strokeWidth: 24,
                    valueColor: AlwaysStoppedAnimation(const Color(0xFF161B22)),
                  ),
                ),
                // Progress
                SizedBox(
                  width: 260,
                  height: 260,
                  child: CircularProgressIndicator(
                    value: 0.65, // ~30 mins / 45ish
                    strokeWidth: 24,
                    strokeCap: StrokeCap.round,
                    valueColor:
                        const AlwaysStoppedAnimation(Color(0xFF227C87)), // Teal
                  ),
                ),
                // Thumb (Mock position)
                Transform.rotate(
                  angle: 1.0, // rads
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      margin: const EdgeInsets.only(
                          right: 20 + 2), // Adjust for track radius
                      width: 32, height: 32,
                      decoration: BoxDecoration(
                        color: const Color(0xFF0D1117),
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: const Color(0xFF227C87), width: 4),
                      ),
                    ),
                  ),
                ),

                // Text
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("$selectedMinutes",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 64,
                            fontWeight: FontWeight.bold)),
                    const Text("MINUTES",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            letterSpacing: 1.5)),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                          color: const Color(0xFF161B22),
                          borderRadius: BorderRadius.circular(4)),
                      child: const Text("11:42 PM",
                          style: TextStyle(
                              color: Color(0xFF227C87),
                              fontWeight: FontWeight.bold,
                              fontSize: 12)),
                    ),
                  ],
                )
              ],
            ),
          ),

          const Spacer(),

          // Grid Presets
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              alignment: WrapAlignment.center,
              children: [
                _buildPresetBtn("10m", false),
                _buildPresetBtn("20m", false),
                _buildPresetBtn("30m", true),
                _buildPresetBtn("45m", false),
                _buildPresetBtn("1h", false),
                _buildPresetBtn("2h", false),
                // End of Track
                Container(
                  width: 160,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: const Color(0xFF161B22),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white10),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.music_note, size: 16, color: Colors.grey),
                      SizedBox(width: 8),
                      Text("End of track",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // Finish last song
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Finish last song",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16)),
                    SizedBox(height: 4),
                    Text("Wait until current track ends",
                        style: TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
                Switch(
                  value: finishLastSong,
                  onChanged: (v) => setState(() => finishLastSong = v),
                  activeColor: Colors.white,
                  activeTrackColor: const Color(0xFF227C87),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // Start Timer
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Cancel",
                        style: TextStyle(color: Colors.white, fontSize: 16))),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF227C87),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 48, vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                  ),
                  child: const Text("Start Timer",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16)),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildPresetBtn(String label, bool isSelected) {
    return Container(
      width: 80,
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF227C87) : const Color(0xFF161B22),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: isSelected ? const Color(0xFF227C87) : Colors.white10),
      ),
      child: Center(
        child: Text(label,
            style: TextStyle(
                color: isSelected ? Colors.black : Colors.white,
                fontWeight: FontWeight.bold)),
      ),
    );
  }
}

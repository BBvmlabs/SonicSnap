import 'package:flutter/material.dart';
import 'package:sonic_snap/features/music/widgets/widgets.dart';
import 'package:sonic_snap/features/songs/widgets/song_art.dart';
import 'package:sonic_snap/features/songs/widgets/song_detils.dart';

class SongDetailsContent extends StatelessWidget {
  final Map<String, dynamic> song;
  final VoidCallback? onClose;
  final bool showCloseButton;

  final bool isScrollable;

  const SongDetailsContent({
    super.key,
    required this.song,
    this.onClose,
    this.showCloseButton = true,
    this.isScrollable = true,
  });

  @override
  Widget build(BuildContext context) {
    final bodyContent = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (showCloseButton)
          Align(
            alignment: Alignment.topRight,
            child: CircleAvatar(
              backgroundColor: Colors.white10,
              radius: 16,
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: const Icon(Icons.close, color: Colors.white, size: 18),
                onPressed: onClose ?? () => Navigator.pop(context),
              ),
            ),
          ),
        const Text(
          "Track Details",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 24),
        SongArt(
            image:
                song['image'] ?? song['artwork'] ?? "assets/logo/play_now.png"),
        const SizedBox(height: 20),
        SongDetails(song: song),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.04),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.05)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("LOCATION",
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.3), fontSize: 10)),
              const SizedBox(height: 6),
              Row(
                children: [
                  Icon(Icons.folder,
                      color: Colors.white.withOpacity(0.3), size: 16),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "/storage/music/${(song['artist'] as String?)?.split('•').first.trim() ?? 'Unknown'}/...",
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.6), fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        _buildActionItem(Icons.edit, "Edit Tags"),
        const SizedBox(height: 12),
        _buildActionItem(Icons.smartphone, "Set as Ringtone"),
        const SizedBox(height: 20),
      ],
    );

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1B162D), // Deep Purple/Dark bg
        borderRadius: isScrollable
            ? const BorderRadius.vertical(top: Radius.circular(24))
            : BorderRadius.circular(24),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: isScrollable
          ? SingleChildScrollView(child: bodyContent)
          : _buildHomeScreenContent(),
    );
  }

  Widget _buildActionItem(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.04),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFB565FF).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.edit, color: Color(0xFFB565FF), size: 18),
          ),
          const SizedBox(width: 16),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          Icon(Icons.chevron_right,
              color: Colors.white.withOpacity(0.2), size: 18),
        ],
      ),
    );
  }

  Widget _buildHomeScreenContent() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.04),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SongArt(
                  image: song['image'] ??
                      song['artwork'] ??
                      "assets/logo/play_now.png"),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      song['title'] ?? "Unknown",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      song['artist'] ?? "Unknown",
                      style: const TextStyle(
                          color: Color(0xFFB565FF),
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SongDetails(song: song, showTitle: false),
          const SizedBox(height: 10),
          _buildActionItem(Icons.edit, "Edit Tags"),
        ],
      ),
    );
  }
}

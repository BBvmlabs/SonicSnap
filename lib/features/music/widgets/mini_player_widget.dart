import 'package:flutter/material.dart';

class MiniPlayerWidget extends StatelessWidget {
  final String title;
  final String image;
  final String description;
  final Color color;
  final bool isPlaying;
  final VoidCallback onTap;
  final VoidCallback onPlayPause;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  const MiniPlayerWidget({
    super.key,
    required this.title,
    required this.image,
    required this.description,
    required this.color,
    required this.isPlaying,
    required this.onTap,
    required this.onPlayPause,
    required this.onPrevious,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 70,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E), // Slightly lighter than black
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Album Art
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                image,
                width: 54,
                height: 54,
                fit: BoxFit.cover,
                errorBuilder: (c, e, s) => Container(
                  width: 54,
                  height: 54,
                  color: Colors.grey[800],
                  child: const Icon(Icons.music_note, color: Colors.white),
                ),
              ),
            ),

            const SizedBox(width: 12),

            // Text Info
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    description,
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 12,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            // Controls
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.skip_previous_rounded,
                      color: Colors.grey[400], size: 28),
                  onPressed: onPrevious,
                ),
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: Colors.purple[100],
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow,
                        color: Colors.black, size: 24),
                    onPressed: onPlayPause,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.skip_next_rounded,
                      color: Colors.grey[400], size: 28),
                  onPressed: onNext,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

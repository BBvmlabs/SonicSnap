import 'package:flutter/material.dart';

class AlbumArtWidget extends StatelessWidget {
  final String image;
  final Color color;
  final bool isPlaying;

  const AlbumArtWidget({
    super.key,
    required this.image,
    required this.color,
    required this.isPlaying,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.5),
              blurRadius: 40,
              spreadRadius: 10,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    color.withOpacity(0.8),
                    color.withOpacity(0.4),
                  ],
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.music_note,
                  size: 120,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

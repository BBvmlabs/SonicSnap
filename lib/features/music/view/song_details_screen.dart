import 'package:flutter/material.dart';
import 'package:sonic_snap/features/songs/view/song_details_scree.dart';

class SongDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> song;

  const SongDetailsScreen({super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF18122B),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Song Details",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SongDetailsContent(
        song: song,
        showCloseButton: false,
      ),
    );
  }
}

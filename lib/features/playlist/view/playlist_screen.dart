import 'package:flutter/material.dart';
import 'package:sonic_snap/features/playlist/widgets/grid_view.dart';
import 'package:sonic_snap/widgets/title_bar.dart';

class PlaylistScreen extends StatefulWidget {
  const PlaylistScreen({super.key});

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  @override
  Widget build(BuildContext context) {
    final isBigScreen = MediaQuery.of(context).size.width > 900;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: isBigScreen
          ? _buildBigScreenLayout()
          : _buildSmallScreenLayout(context),
    );
  }

  Widget _buildBigScreenLayout() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildTitleBar("PLAYLISTS"),
          const PlaylistGridWidget(),
          const SizedBox(height: 100), // Space for mini player
        ],
      ),
    );
  }

  Widget _buildSmallScreenLayout(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildMobileTitleBar(context, Icons.playlist_play, 'PLAYLISTS'),
            const PlaylistGridWidget(),
            const SizedBox(height: 100), // Space for mini player
          ],
        ),
      ),
    );
  }
}

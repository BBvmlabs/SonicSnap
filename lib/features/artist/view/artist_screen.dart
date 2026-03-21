import 'package:flutter/material.dart';
import 'package:sonic_snap/features/artist/widgets/grid_view.dart';
import 'package:sonic_snap/widgets/title_bar.dart';

class ArtistScreen extends StatefulWidget {
  const ArtistScreen({super.key});

  @override
  State<ArtistScreen> createState() => _ArtistScreenState();
}

class _ArtistScreenState extends State<ArtistScreen> {
  @override
  Widget build(BuildContext context) {
    final isBigScreen = MediaQuery.of(context).size.width > 900;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: isBigScreen
          ? _buildDesktopScreenLayout()
          : _buildMobileScreenLayout(context),
    );
  }

  Widget _buildDesktopScreenLayout() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildTitleBar("ARTISTS"),
          const ArtistGridWidget(),
          const SizedBox(height: 100), // Space for mini player
        ],
      ),
    );
  }

  Widget _buildMobileScreenLayout(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildMobileTitleBar(context, Icons.person, 'ARTISTS'),
            const ArtistGridWidget(),
            const SizedBox(height: 100), // Space for mini player
          ],
        ),
      ),
    );
  }
}

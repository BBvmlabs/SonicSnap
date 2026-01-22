import 'package:flutter/material.dart';
import 'package:sonic_snap/features/music/widgets/bottom_sheets.dart';

class AlbumDetailsScreen extends StatelessWidget {
  final String title;
  final String artist;
  final String image;

  const AlbumDetailsScreen({
    super.key,
    required this.title,
    required this.artist,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFF2F2F7), // Light background like screenshot
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE0D8F0), // Light Purple top
              Color(0xFFF5F5F7), // White bottom
            ],
          ),
        ),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.transparent,
              leading: IconButton(
                icon: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.black12, shape: BoxShape.circle),
                  child: Icon(Icons.arrow_back, color: Colors.black),
                ),
                onPressed: () => Navigator.pop(context),
              ),
              actions: [
                IconButton(
                  icon: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.black12, shape: BoxShape.circle),
                    child: Icon(Icons.cast, color: Colors.black),
                  ),
                  onPressed: () {},
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    child: Icon(Icons.wb_sunny_outlined, color: Colors.black),
                  ),
                  onPressed: () {},
                ),
                const SizedBox(width: 16),
              ],
              expandedHeight: 0,
              floating: true,
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    // Album Art
                    Container(
                      height: 240,
                      width: 240,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.purple.withOpacity(0.2),
                              blurRadius: 40,
                              offset: const Offset(0, 20)),
                        ],
                        image: DecorationImage(
                            image: AssetImage(image), fit: BoxFit.cover),
                      ),
                    ),
                    const SizedBox(height: 24),

                    Text(title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                    const SizedBox(height: 8),
                    Text(artist,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 18,
                            color: Colors.purpleAccent,
                            fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    Text("ELECTRONIC • 1997 • HI-RES",
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                            letterSpacing: 1.2)),

                    const SizedBox(height: 32),

                    // Actions
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildButton(Icons.shuffle, "Shuffle", false),
                        _buildButton(Icons.play_arrow, "Play", true),
                        _buildCircleBtn(Icons.download_rounded),
                        _buildCircleBtn(Icons.more_vert),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return _buildTrackItem(context, index + 1);
                },
                childCount: 10,
              ),
            ),

            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(32),
                child: Column(
                  children: [
                    Text("© 1997 XL Recordings",
                        style: TextStyle(color: Colors.grey)),
                    Text("Total Duration: 56:24",
                        style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
            ),
            // Space for mini player
            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
    );
  }

  Widget _buildTrackItem(BuildContext context, int index) {
    final titles = [
      "Smack My Bitch Up",
      "Breathe",
      "Diesel Power",
      "Funky Shit",
      "Serial Thrilla",
      "Mindfields",
      "Narayan",
      "Firestarter",
      "Climbatize",
      "Fuel My Fire"
    ];
    final isPlaying = index == 3; // Mock

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      leading: SizedBox(
        width: 30,
        child: isPlaying
            ? const Icon(Icons.bar_chart, color: Colors.purpleAccent)
            : Text("$index",
                style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
      ),
      title: Text(titles[index - 1],
          style: TextStyle(
              color: isPlaying ? Colors.purpleAccent : Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 16)),
      trailing: IconButton(
        icon: const Icon(Icons.more_vert, color: Colors.grey),
        onPressed: () {
          // Show context menu
          showSongOptionsSheet(context, {
            'title': titles[index - 1],
            'artist': 'The Prodigy',
            'image': image,
          });
        },
      ),
      onTap: () {},
    );
  }

  Widget _buildButton(IconData icon, String label, bool isPrimary) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: isPrimary ? const Color(0xFFA855F7) : Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          if (!isPrimary)
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4)),
          if (isPrimary)
            BoxShadow(
                color: const Color(0xFFA855F7).withOpacity(0.4),
                blurRadius: 10,
                offset: const Offset(0, 4)),
        ],
      ),
      child: Row(
        children: [
          Icon(icon,
              color: isPrimary ? Colors.white : Colors.black87, size: 20),
          const SizedBox(width: 8),
          Text(label,
              style: TextStyle(
                  color: isPrimary ? Colors.white : Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildCircleBtn(IconData icon) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4)),
        ],
      ),
      child: Icon(icon, color: Colors.black87),
    );
  }
}

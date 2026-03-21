import 'package:flutter/material.dart';
import 'package:sonic_snap/data/dummy_data.dart';
import 'package:sonic_snap/widgets/app_logo.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    bool isBigScreen = MediaQuery.of(context).size.width > 900;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: isBigScreen
          ? CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(40, 48, 40, 20),
                    child: _buildGreeting(),
                  ),
                ),
                SliverToBoxAdapter(
                  child: _buildLikedSection(isBigScreen),
                ),
                SliverToBoxAdapter(
                  child: _buildSectionTitle("LAST PLAYED"),
                ),
                SliverToBoxAdapter(
                  child: _buildHorizontalCardList(isBigScreen, height: 220),
                ),
                SliverToBoxAdapter(
                  child: _buildSectionTitle("TOP 50 GLOBAL"),
                ),
                SliverToBoxAdapter(
                  child: _buildHorizontalCardList(isBigScreen,
                      height: 180, isCircular: true),
                ),
                SliverToBoxAdapter(
                  child: _buildSectionTitle("RECENTLY ADDED PLAYLISTS"),
                ),
                SliverToBoxAdapter(
                  child: _buildHorizontalCardList(isBigScreen, height: 200),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 120), // bottom padding for player
                ),
              ],
            )
          : SafeArea(
              child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 10),
                        child: Row(
                          children: [
                            insideAppLogo(270),
                            const Spacer(),
                            IconButton(
                              icon: const Icon(Icons.more_vert),
                              onPressed: () {
                                // TODO: implement settings
                              },
                            ),
                          ],
                        ))),
                SliverToBoxAdapter(
                  child: _buildLikedSection(isBigScreen),
                ),
                SliverToBoxAdapter(
                  child: _buildSectionTitle("LAST PLAYED"),
                ),
                SliverToBoxAdapter(
                  child: _buildHorizontalCardList(isBigScreen, height: 220),
                ),
                SliverToBoxAdapter(
                  child: _buildSectionTitle("TOP 50 GLOBAL"),
                ),
                SliverToBoxAdapter(
                  child: _buildHorizontalCardList(isBigScreen,
                      height: 180, isCircular: true),
                ),
                SliverToBoxAdapter(
                  child: _buildSectionTitle("RECENTLY ADDED PLAYLISTS"),
                ),
                SliverToBoxAdapter(
                  child: _buildHorizontalCardList(isBigScreen, height: 200),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 120), // bottom padding for player
                ),
              ],
            )),
    );
  }

  Widget _buildGreeting() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "WELCOME BACK",
          style: TextStyle(
            color: Colors.cyanAccent.shade400,
            fontSize: 24,
            fontWeight: FontWeight.w900,
            letterSpacing: 3.0,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          "YOUR SOUNDSCAPE",
          style: TextStyle(
            color: Colors.white,
            fontSize: 48,
            fontWeight: FontWeight.w900,
            letterSpacing: -1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 40, 40, 20),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w900,
          letterSpacing: 1.5,
        ),
      ),
    );
  }

  Widget _buildLikedSection(bool isBigScreen) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: isBigScreen
          ? Row(
              children: [
                Expanded(
                    child: _buildSpecialCard(
                        isBigScreen,
                        "LIKED SONGS",
                        "342 Tracks",
                        [
                          const Color.fromARGB(255, 202, 51, 51),
                          const Color.fromARGB(255, 242, 96, 96)
                        ],
                        icon: Icons.favorite)),
                const SizedBox(width: 24),
                Expanded(
                    child: _buildSpecialCard(
                        isBigScreen,
                        "SAVED ALBUMS",
                        "18 Albums",
                        [const Color(0xFFE64A19), const Color(0xFFFFD54F)],
                        icon: Icons.album)),
                const SizedBox(width: 24),
                Expanded(
                    child: _buildSpecialCard(
                        isBigScreen,
                        "Top Songs",
                        "18 Tracks",
                        [const Color(0xFF4527A0), const Color(0xFF00E5FF)],
                        icon: Icons.replay_sharp)),
              ],
            )
          : Row(
              children: [
                _buildSpecialCard(
                    isBigScreen,
                    "LIKED SONGS",
                    "342 Tracks",
                    [
                      const Color.fromARGB(255, 202, 51, 51),
                      const Color.fromARGB(255, 242, 96, 96),
                    ],
                    icon: Icons.favorite),
                const SizedBox(width: 20),
                _buildSpecialCard(isBigScreen, "TOP ALBUMS", "18 Albums",
                    [const Color(0xFFE64A19), const Color(0xFFFFD54F)],
                    icon: Icons.album),
              ],
            ),
    );
  }

  Widget _buildSpecialCard(
      bool isBigScreen, String title, String subtitle, List<Color> colors,
      {IconData icon = Icons.music_note}) {
    return Container(
      height: 140,
      width: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: colors[0].withValues(alpha: 0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          )
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20,
            bottom: -20,
            child: Icon(icon,
                size: 120, color: Colors.white.withValues(alpha: 0.2)),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.0,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.8),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHorizontalCardList(bool isBigScreen,
      {required double height, bool isCircular = false}) {
    return SizedBox(
      height: height,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        scrollDirection: Axis.horizontal,
        itemCount: dummySongs.length,
        itemBuilder: (context, index) {
          final song = dummySongs[index];
          return Container(
            width: isCircular ? height - 40 : 160,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              crossAxisAlignment: isCircular
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      shape: isCircular ? BoxShape.circle : BoxShape.rectangle,
                      borderRadius:
                          isCircular ? null : BorderRadius.circular(12),
                      image: DecorationImage(
                        image: AssetImage(song['image']),
                        fit: BoxFit.cover,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.4),
                          blurRadius: 10,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  song['title'].toUpperCase(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: isCircular ? TextAlign.center : TextAlign.left,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  song['artist'].split(' • ')[0],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: isCircular ? TextAlign.center : TextAlign.left,
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

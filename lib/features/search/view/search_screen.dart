import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  final bool isBigScreen;
  final List<String> recentSearches;
  final List<Map<String, dynamic>> songs;
  const SearchScreen(
      {super.key,
      required this.isBigScreen,
      required this.recentSearches,
      required this.songs});

  @override
  Widget build(BuildContext context) {
    final isBigScreen = MediaQuery.of(context).size.width > 900;
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      body: isBigScreen ? _buildWideSearchView() : _buildMobileSearchView(),
      bottomNavigationBar: isBigScreen
          ? null
          : BottomNavigationBar(
              backgroundColor: const Color(0xFF0F0F0F),
              selectedItemColor: Colors.blueAccent,
              unselectedItemColor: Colors.grey,
              currentIndex: 1,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.search), label: "Search"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.library_music), label: "Library"),
              ],
            ),
    );
  }

  Widget _buildMobileSearchView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: CustomScrollView(
        slivers: [
          // Header
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: Text("Search",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold)),
            ),
          ),

          // Search Bar
          SliverToBoxAdapter(
            child: Container(
              height: 56,
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E),
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Row(
                children: [
                  Icon(Icons.search, color: Colors.grey),
                  SizedBox(width: 16),
                  Expanded(
                      child: Text("Songs, artists, albums...",
                          style: TextStyle(color: Colors.grey, fontSize: 16))),
                  Icon(Icons.mic, color: Colors.blueAccent),
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 32)),

          // Recent Searches
          SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Recent Searches",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                TextButton(
                    onPressed: () {},
                    child: const Text("CLEAR",
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 12))),
              ],
            ),
          ),

          SliverToBoxAdapter(
            child: Row(
              children: [
                _buildRecentChip("Techno Bunker"),
                const SizedBox(width: 12),
                _buildRecentChip("Hans Zimmer"),
              ],
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 32)),

          // Top Genres
          const SliverToBoxAdapter(
            child: Text("Top Genres",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 16)),

          SliverToBoxAdapter(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildGenreChip("Rock", Colors.teal),
                  const SizedBox(width: 12),
                  _buildGenreChip("K-Pop", Colors.grey),
                  const SizedBox(width: 12),
                  _buildGenreChip("Hip-Hop", Colors.grey),
                  const SizedBox(width: 12),
                  _buildGenreChip("Classical", Colors.grey),
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 32)),

          // Trending Now
          const SliverToBoxAdapter(
            child: Text("Trending Now",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 16)),

          SliverList(
            delegate: SliverChildListDelegate([
              _buildTrendingItem(
                  "Blinding Lights", "The Weeknd", Colors.redAccent),
              _buildTrendingItem("Levitating", "Dua Lipa", Colors.pinkAccent),
              _buildTrendingItem(
                  "Stay", "The Kid LAROI & Justin Bieber", Colors.blueAccent),
              _buildTrendingItem(
                  "Good 4 U", "Olivia Rodrigo", Colors.orangeAccent),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          const Icon(Icons.history, color: Colors.grey, size: 18),
          const SizedBox(width: 8),
          Text(label,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold)),
          const SizedBox(width: 8),
          const Icon(Icons.close, color: Colors.grey, size: 18),
        ],
      ),
    );
  }

  Widget _buildGenreChip(String label, Color color) {
    final isSelected = color == Colors.teal;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF0F2C31) : const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(24),
        border: isSelected ? Border.all(color: color) : null,
      ),
      child: Text(label,
          style: TextStyle(
              color: isSelected ? color : Colors.white,
              fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildTrendingItem(String title, String artist, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: LinearGradient(
                  colors: [color.withValues(alpha: 0.8), Colors.black]),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16)),
                const SizedBox(height: 4),
                Text(artist,
                    style: const TextStyle(color: Colors.grey, fontSize: 14)),
              ],
            ),
          ),
          const Icon(Icons.more_vert, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildWideSearchView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top Logo/Icon row
        Padding(
          padding: const EdgeInsets.fromLTRB(40, 32, 40, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'VIBEENGINE',
                style: TextStyle(
                  color: Colors.cyanAccent.shade400,
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.0,
                ),
              ),
              const Row(
                children: [
                  Icon(Icons.wifi_tethering,
                      color: Colors.cyanAccent, size: 20),
                  SizedBox(width: 24),
                  Icon(Icons.account_circle_outlined,
                      color: Colors.white70, size: 20),
                ],
              ),
            ],
          ),
        ),

        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Big Search Input
                Container(
                  height: 80,
                  decoration: BoxDecoration(
                    color: const Color(0xFF161B22).withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.white10),
                  ),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 32),
                        child: Icon(Icons.search,
                            color: Colors.cyanAccent, size: 28),
                      ),
                      const Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText:
                                'SEARCH FREQUENCIES, ARTISTS, OR ANALOG TEXTURES',
                            hintStyle: TextStyle(
                                color: Colors.white12,
                                fontSize: 24,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1.0),
                            border: InputBorder.none,
                          ),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 32),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Colors.white10),
                        ),
                        child: const Row(
                          children: [
                            Text('CTRL',
                                style: TextStyle(
                                    color: Colors.white24, fontSize: 10)),
                            SizedBox(width: 8),
                            Text('K',
                                style: TextStyle(
                                    color: Colors.white24, fontSize: 10)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 64),

                // Recent Signals
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'RECENT SIGNALS',
                      style: TextStyle(
                        color: Colors.white24,
                        fontSize: 12,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2.0,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'CLEAR BUFFER',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    _buildSignalChip('ATMOSPHERIC VOID'),
                    _buildSignalChip('MODULAR SYNTH 440HZ'),
                    _buildSignalChip('REVERB DEEP SPACE'),
                    _buildSignalChip('TECHNO INDUSTRIAL'),
                  ],
                ),

                const SizedBox(height: 84),

                // Sonic Domains
                const Text(
                  'SONIC DOMAINS',
                  style: TextStyle(
                    color: Colors.white24,
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2.0,
                  ),
                ),
                const SizedBox(height: 32),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 24,
                  crossAxisSpacing: 24,
                  childAspectRatio: 2.0,
                  children: [
                    _buildDomainCard('TECHNO', '128-145 BPM', songs[0]['image'],
                        Colors.purple.shade900, true),
                    _buildDomainCard('AMBIENT', null, songs[1]['image'],
                        Colors.teal.shade900, false),
                    _buildDomainCard('INDUSTRIAL', null, songs[2]['image'],
                        Colors.blueGrey.shade900, false),
                    _buildDomainCard('PHONK', null, songs[3]['image'],
                        Colors.red.shade900, false),
                  ],
                ),

                const SizedBox(height: 100),

                // Peak Frequencies Footer
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'PEAK FREQUENCIES',
                      style: TextStyle(
                        color: Colors.white10,
                        fontSize: 11,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2.0,
                      ),
                    ),
                    Row(
                      children: [
                        Text('GLOBAL',
                            style: TextStyle(
                                color: Colors.cyanAccent.shade400,
                                fontSize: 10,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(width: 24),
                        const Text('LOCAL',
                            style: TextStyle(
                                color: Colors.white10,
                                fontSize: 10,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 150),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSignalChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF161B22).withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 11,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(width: 12),
          const Icon(Icons.close, color: Colors.white12, size: 14),
        ],
      ),
    );
  }

  Widget _buildDomainCard(String title, String? subtitle, String imageUrl,
      Color color, bool isLarge) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        image: DecorationImage(
          image: AssetImage(imageUrl),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
              color.withValues(alpha: 0.6), BlendMode.multiply),
        ),
      ),
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 48,
              fontWeight: FontWeight.w900,
              letterSpacing: -1.0,
            ),
          ),
          if (subtitle != null)
            Container(
              margin: const EdgeInsets.only(top: 12),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.cyanAccent.withValues(alpha: 0.1),
                border:
                    Border.all(color: Colors.cyanAccent.withValues(alpha: 0.3)),
                borderRadius: BorderRadius.circular(2),
              ),
              child: Text(
                subtitle,
                style: const TextStyle(
                  color: Colors.cyanAccent,
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

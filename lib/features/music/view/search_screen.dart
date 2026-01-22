import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      body: SafeArea(
        child: Padding(
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
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 16))),
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
                  _buildTrendingItem(
                      "Levitating", "Dua Lipa", Colors.pinkAccent),
                  _buildTrendingItem("Stay", "The Kid LAROI & Justin Bieber",
                      Colors.blueAccent),
                  _buildTrendingItem(
                      "Good 4 U", "Olivia Rodrigo", Colors.orangeAccent),
                ]),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF0F0F0F),
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        currentIndex: 1,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(
              icon: Icon(Icons.library_music), label: "Library"),
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
                  colors: [color.withOpacity(0.8), Colors.black]),
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
}

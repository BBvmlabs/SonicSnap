import 'package:flutter/material.dart';
import 'package:sonic_snap/features/music/view/play_now.dart';
import 'package:sonic_snap/features/music/widgets/widgets.dart';
import 'package:sonic_snap/features/music/widgets/bottom_sheets.dart';
import 'package:sonic_snap/routes/navigator.dart';
import 'package:sonic_snap/routes/router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isPlayerExpanded = false;
  bool isBigScreen = false;

  final List<Map<String, dynamic>> _songs = [
    {
      "title": "Diesel Power",
      "artist": "The Prodigy • The Fat of the Land",
      "image": "assets/logo/play_now.png",
      "color": Colors.purple,
      "duration": "4:18",
    },
    {
      "title": "Midnight City",
      "artist": "M83 • Hurry Up, We're Dreaming",
      "image": "assets/logo/play_now.png",
      "color": Colors.blue,
      "duration": "4:03",
    },
    {
      "title": "Breathe",
      "artist": "The Prodigy • The Fat of the Land",
      "image": "assets/logo/play_now.png",
      "color": Colors.red,
      "duration": "5:35",
    },
    {
      "title": "Clair de Lune",
      "artist": "Claude Debussy • Suite bergamasque",
      "image": "assets/logo/play_now.png",
      "color": Colors.orange,
      "duration": "5:12",
    },
    {
      "title": "Instant Crush",
      "artist": "Daft Punk ft. Julian Casablancas",
      "image": "assets/logo/play_now.png",
      "color": Colors.blueGrey,
      "duration": "5:37",
    },
    {
      "title": "Opus",
      "artist": "Eric Prydz • Opus",
      "image": "assets/logo/play_now.png",
      "color": Colors.teal,
      "duration": "9:03",
    },
    {
      "title": "Firestarter",
      "artist": "The Prodigy",
      "image": "assets/logo/play_now.png",
      "color": Colors.orangeAccent,
      "duration": "4:40",
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  void _togglePlayer() {
    setState(() {
      isPlayerExpanded = !isPlayerExpanded;
    });
  }

  void _navigateToAlbum(Map<String, dynamic> song) {
    navigate(context, AppRouter.albumScreen, extra: {
      'title': "The Fat of the Land",
      'artist': "The Prodigy",
      'image': song['image'],
    });
  }

  @override
  Widget build(BuildContext context) {
    isBigScreen = MediaQuery.of(context).size.width > 600;
    return PopScope(
      canPop: !isPlayerExpanded,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        _togglePlayer();
      },
      child: Scaffold(
        backgroundColor: Colors.black, // Dark mode base
        body: Stack(
          children: [
            // Main Scrollable Content
            NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    backgroundColor: Colors.black,
                    expandedHeight: 120,
                    floating: false,
                    pinned: true,
                    elevation: 0,
                    title: Image.asset(
                      "assets/logo/logo.png",
                      width: isBigScreen ? 270 : 170,
                    ),
                    centerTitle: false,
                    actions: [
                      Row(
                        children: [
                          const Text("Offline Mode",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12)),
                          Switch(
                            value: false,
                            onChanged: (v) {},
                            activeThumbColor: Colors.purpleAccent,
                          ),
                          IconButton(
                              onPressed: () {
                                navigate(context, AppRouter.settingsScreen);
                              },
                              icon: const Icon(Icons.more_vert,
                                  color: Colors.white))
                        ],
                      )
                    ],
                    bottom: PreferredSize(
                      preferredSize: const Size.fromHeight(48),
                      child: Container(
                        color: Colors.black,
                        child: TabBar(
                          controller: _tabController,
                          isScrollable: true,
                          indicatorColor: Colors.purpleAccent,
                          indicatorWeight: 3,
                          labelColor: Colors.purpleAccent,
                          unselectedLabelColor: Colors.grey,
                          labelStyle: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                          tabs: const [
                            Tab(text: "Tracks"),
                            Tab(text: "Downloads"),
                            Tab(text: "Albums"),
                            Tab(text: "Artists"),
                          ],
                        ),
                      ),
                    ),
                  ),
                ];
              },
              body: Column(
                children: [
                  // Search Bar Zone
                  GestureDetector(
                    onTap: () {
                      navigate(context, AppRouter.searchScreen);
                    },
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                      color: Colors.black,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.search, color: Colors.grey[500]),
                            const SizedBox(width: 12),
                            Text(
                              "Search tracks...",
                              style: TextStyle(
                                  color: Colors.grey[500], fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Stats & Buttons Row
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    color: Colors.black,
                    child: Row(
                      children: [
                        Text("${_songs.length} Tracks",
                            style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 14,
                                fontWeight: FontWeight.w500)),
                        const Spacer(),
                        // Shuffle Button
                        _buildActionButton(
                            Icons.shuffle,
                            "Shuffle",
                            Colors.purpleAccent.withOpacity(0.1),
                            Colors.purpleAccent),
                        const SizedBox(width: 8),
                        // Play All Button
                        _buildActionButton(
                            Icons.play_arrow,
                            "Play All",
                            Colors.purpleAccent.withOpacity(0.1),
                            Colors.purpleAccent),
                      ],
                    ),
                  ),

                  // Song List
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.only(bottom: 100),
                      itemCount: _songs.length,
                      itemBuilder: (context, index) {
                        final song = _songs[index];
                        return SongCard(
                          title: song['title'],
                          artist: song['artist'],
                          imageUrl: song['image'],
                          color: song['color'],
                          duration: song['duration'] ?? "3:45",
                          isPlaying: index == 0,
                          onTap: () {
                            if (!isPlayerExpanded) {
                              _togglePlayer();
                            }
                          },
                          onMore: () {
                            showSongOptionsSheet(
                              context,
                              song,
                              onAlbumTap: () => _navigateToAlbum(song),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Mini Player Overlay
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: PlayNowScreen(
                isExpanded: isPlayerExpanded,
                title: "Diesel Power",
                image: "assets/logo/play_now.png",
                description: "The Prodigy",
                onTap: _togglePlayer, // Tap mini player -> Toggle
                onPrevious: () {},
                onNext: () {},
                onPressed: () {},
                color: Colors.purple,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(
      IconData icon, String label, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: textColor),
          const SizedBox(width: 6),
          Text(label,
              style: TextStyle(
                  color: textColor, fontWeight: FontWeight.bold, fontSize: 12)),
        ],
      ),
    );
  }
}

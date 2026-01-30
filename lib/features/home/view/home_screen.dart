import 'package:flutter/material.dart';
import 'package:sonic_snap/features/music/view/play_now.dart';
import 'package:sonic_snap/features/music/widgets/widgets.dart';
import 'package:sonic_snap/features/music/widgets/bottom_sheets.dart';
import 'package:sonic_snap/features/songs/view/song_details_scree.dart';
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
  bool isPlaying = false;
  bool isPlayerExpanded = false;
  bool isBigScreen = false;
  int _selectedSongIndex = 0;

  void _nextSong() {
    setState(() {
      _selectedSongIndex = (_selectedSongIndex + 1) % _songs.length;
    });
  }

  void _previousSong() {
    setState(() {
      _selectedSongIndex =
          (_selectedSongIndex - 1 + _songs.length) % _songs.length;
    });
  }

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
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            // Side-by-Side Content for Big Screens
            Row(
              children: [
                // Library Area
                Expanded(
                  flex: isBigScreen ? 4 : 1,
                  child: NestedScrollView(
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
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 12)),
                                  Switch(
                                    value: false,
                                    onChanged: (v) {},
                                    activeThumbColor: Colors.purpleAccent,
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        navigate(
                                            context, AppRouter.settingsScreen);
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
                                  indicatorWeight: 3,
                                  labelColor: Colors.purpleAccent,
                                  unselectedLabelColor: Colors.grey,
                                  labelStyle: Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                      ?.copyWith(
                                        color: Theme.of(context).primaryColor,
                                      ),
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
                      body: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: isBigScreen ? 4 : 1,
                            child: Column(
                              children: [
                                _buildSearchZone(),
                                _buildStatsAndButtonsRow(),
                                _buildSongList(),
                              ],
                            ),
                          ),
                          if (isBigScreen) ...[
                            const VerticalDivider(
                                width: 1, color: Colors.white12),
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 80), // Respect mini player
                                child: SongDetailsContent(
                                  song: _songs[_selectedSongIndex],
                                  showCloseButton: false,
                                  isScrollable: false,
                                ),
                              ),
                            ),
                          ],
                        ],
                      )),
                ),
              ],
            ),

            // Mini Player Overlay at the bottom
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: PlayNowScreen(
                isExpanded: isPlayerExpanded,
                title: _songs[_selectedSongIndex]['title'],
                image: _songs[_selectedSongIndex]['image'],
                description: _songs[_selectedSongIndex]['artist'],
                isPlaying: isPlaying,
                onTap: _togglePlayer,
                onPlayPause: () {
                  setState(() {
                    isPlaying = !isPlaying;
                  });
                },
                onPrevious: _previousSong,
                onNext: _nextSong,
                color: _songs[_selectedSongIndex]['color'],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchZone() {
    return GestureDetector(
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
                style: TextStyle(color: Colors.grey[500], fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatsAndButtonsRow() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      color: Colors.black,
      child: Row(
        children: [
          Text("${_songs.length} Tracks",
              style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 14,
                  fontWeight: FontWeight.w500)),
          const Spacer(),
          _buildActionButton(Icons.shuffle, "Shuffle",
              Colors.purpleAccent.withOpacity(0.1), Colors.purpleAccent),
          const SizedBox(width: 8),
          _buildActionButton(Icons.play_arrow, "Play All",
              Colors.purpleAccent.withOpacity(0.1), Colors.purpleAccent),
        ],
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

  Widget _buildSongList() {
    return Expanded(
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
            isSelected: _selectedSongIndex == index,
            isPlaying: isPlaying && _selectedSongIndex == index,
            onTap: () {
              setState(() {
                _selectedSongIndex = index;
                isPlaying = true;
              });
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
    );
  }
}

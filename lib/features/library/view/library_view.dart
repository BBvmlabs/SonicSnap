import 'package:flutter/material.dart';
import 'package:sonic_snap/features/artist/view/artist_view.dart';
import 'package:sonic_snap/features/home/view/home_screen.dart';
import 'package:sonic_snap/features/home/widgets/sidebar.dart';
import 'package:sonic_snap/features/music/view/play_now.dart';
import 'package:sonic_snap/features/search/view/search_screen.dart';
import 'package:sonic_snap/features/music/widgets/widgets.dart';
import 'package:sonic_snap/features/music/widgets/bottom_sheets.dart';
import 'package:sonic_snap/routes/navigator.dart';
import 'package:sonic_snap/routes/router.dart';
import 'package:sonic_snap/widgets/build_tag.dart';

class LibraryView extends StatefulWidget {
  const LibraryView({super.key});

  @override
  State<LibraryView> createState() => _LibraryViewState();
}

enum LibraryNav { album, tracks, playlists, artists }

class _LibraryViewState extends State<LibraryView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isPlaying = false;
  bool isPlayerExpanded = false;
  bool isBigScreen = false;
  int _selectedSongIndex = 0;
  LibraryNav _currentNav = LibraryNav.album;

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

  Widget _buildLogo(double width) {
    return Image.asset(
      "assets/logo/appinsidelogo.png",
      width: width,
    );
  }

  Widget _buildActions() {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            navigate(context, AppRouter.settingsScreen);
          },
          icon: const Icon(Icons.more_vert, color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildSmallScreenLayout() {
    switch (_currentNav) {
      case LibraryNav.album:
        return Column(
          children: [
            _buildMobileTopUtilityBar(),
            _buildStatsAndButtonsRow(),
            _buildSongList(),
          ],
        );
      case LibraryNav.tracks:
        return ArtistView(songs: _songs, isBigScreen: isBigScreen);
      case LibraryNav.playlists:
        return ArtistView(songs: _songs, isBigScreen: isBigScreen);
      case LibraryNav.artists:
        return SearchScreen(
          isBigScreen: isBigScreen,
          songs: _songs,
          recentSearches: const ['Techno Bunker', 'Hans Zimmer'],
        );
    }
  }

  Widget _buildMobileTopUtilityBar() {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildLogo(220),
                _buildActions(),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'LIBRARY',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.w900,
                letterSpacing: -1.0,
              ),
            ),
            const SizedBox(height: 16),
            TabBar(
              controller: _tabController,
              isScrollable: true,
              indicatorColor: Colors.cyanAccent.shade400,
              indicatorWeight: 3,
              indicatorSize: TabBarIndicatorSize.label,
              labelColor: Colors.cyanAccent.shade400,
              unselectedLabelColor: Colors.grey[700],
              dividerColor: Colors.transparent,
              labelPadding: const EdgeInsets.only(right: 18),
              tabAlignment: TabAlignment.start,
              unselectedLabelStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.0,
              ),
              labelStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w900,
                letterSpacing: 2.0,
              ),
              tabs: const [
                Tab(text: "ALBUMS"),
                Tab(text: "TRACKS"),
                Tab(text: "ARTISTS"),
                Tab(text: "PLAYLISTS"),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Text(
                  'SORT BY: RECENTLY ADDED',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.0,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(Icons.tune_rounded, color: Colors.grey[600], size: 16),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBigScreenLayout() {
    return Row(
      children: [
        // 1. Fixed Sidebar Navigation
        Sidebar(
          currentNav: NavState.album,
          onNavChanged: (nav) {
            // Main navigation handled externally
          },
        ),

        // 2. Main Content Area
        Expanded(
          child: _buildMainContent(),
        ),
      ],
    );
  }

  Widget _buildMainContent() {
    switch (_currentNav) {
      case LibraryNav.album:
        return Column(
          children: [
            _buildTopUtilityBar(),
            _buildTableHeadings(),
            const Divider(
                height: 1, color: Colors.white10, indent: 32, endIndent: 32),
            Expanded(child: _buildSongTable()),
          ],
        );
      case LibraryNav.tracks:
        return ArtistView(songs: _songs, isBigScreen: isBigScreen);
      case LibraryNav.playlists:
        return ArtistView(songs: _songs, isBigScreen: isBigScreen);
      case LibraryNav.artists:
        return SearchScreen(
          isBigScreen: isBigScreen,
          songs: _songs,
          recentSearches: const ['Techno Bunker', 'Hans Zimmer'],
        );
    }
  }

  Widget _buildTopUtilityBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 32, 40, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'LIBRARY',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 56,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -2.0,
                ),
              ),
              const Spacer(),
              Expanded(child: _buildSearchZone()),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TabBar(
                controller: _tabController,
                isScrollable: true,
                indicatorColor: Colors.cyanAccent.shade400,
                indicatorWeight: 3,
                indicatorSize: TabBarIndicatorSize.label,
                labelColor: Colors.cyanAccent.shade400,
                unselectedLabelColor: Colors.grey[700],
                dividerColor: Colors.transparent, // We use our own divider
                labelPadding: const EdgeInsets.only(right: 48),
                tabAlignment: TabAlignment.start,
                labelStyle: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2.0,
                ),
                tabs: const [
                  Tab(text: "TRACKS"),
                  Tab(text: "DOWNLOADS"),
                  Tab(text: "ALBUMS"),
                  Tab(text: "ARTISTS"),
                ],
              ),
              Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    children: [
                      Text(
                        'SORT BY: RECENTLY ADDED',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.0,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(Icons.tune_rounded,
                          color: Colors.grey[600], size: 16),
                    ],
                  )),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTableHeadings() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(40, 32, 40, 12),
      child: Row(
        children: [
          SizedBox(width: 50, child: Text('#', style: _headingStyle)),
          Expanded(flex: 5, child: Text('TRACK DETAILS', style: _headingStyle)),
          Expanded(flex: 3, child: Text('ALBUM', style: _headingStyle)),
          Expanded(flex: 2, child: Text('DURATION', style: _headingStyle)),
          SizedBox(
              width: 120,
              child: Text('ENCODING',
                  style: _headingStyle, textAlign: TextAlign.right)),
        ],
      ),
    );
  }

  static const _headingStyle = TextStyle(
    color: Colors.white12,
    fontSize: 11,
    fontWeight: FontWeight.w900,
    letterSpacing: 2.0,
  );

  Widget _buildSongTable() {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 150),
      itemCount: _songs.length,
      itemBuilder: (context, index) {
        final song = _songs[index];
        final isSelected = _selectedSongIndex == index;
        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedSongIndex = index;
              isPlaying = true;
            });
          },
          child: Container(
            height: 72,
            margin: const EdgeInsets.symmetric(horizontal: 0),
            padding: const EdgeInsets.symmetric(horizontal: 40),
            decoration: BoxDecoration(
              color: isSelected
                  ? const Color(0xFF161B22).withValues(alpha: 0.5)
                  : Colors.transparent,
              border: isSelected
                  ? const Border(
                      left: BorderSide(color: Colors.cyanAccent, width: 3),
                    )
                  : null,
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 50,
                  child: Text(
                    (index + 1).toString().padLeft(2, '0'),
                    style: TextStyle(
                      color: isSelected
                          ? Colors.cyanAccent.shade400
                          : Colors.grey[800],
                      fontSize: 14,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                          image: DecorationImage(
                            image: AssetImage(song['image']),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            song['title'].toUpperCase(),
                            style: TextStyle(
                              color: isSelected
                                  ? Colors.cyanAccent.shade400
                                  : Colors.white.withValues(alpha: 0.9),
                              fontSize: 15,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1.0,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            song['artist'].split(' • ')[0],
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    "SYNTHETIC HORIZONS VOL. 1",
                    style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 13,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    song['duration'] ?? "04:32",
                    style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 13,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  width: 120,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      buildTag('FLAC'),
                      const SizedBox(width: 8),
                      buildTag('24-BIT', color: Colors.purple.shade900),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    isBigScreen = MediaQuery.of(context).size.width >
        900; // Increased threshold for wide layout
    return PopScope(
      canPop: !isPlayerExpanded,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        _togglePlayer();
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF0D1117),
        bottomNavigationBar: isBigScreen
            ? null
            : BottomNavigationBar(
                backgroundColor: const Color(0xFF080C11),
                selectedItemColor: Colors.cyanAccent.shade400,
                unselectedItemColor: Colors.grey[600],
                selectedLabelStyle: const TextStyle(
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.0,
                    fontSize: 10),
                unselectedLabelStyle: const TextStyle(
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.0,
                    fontSize: 10),
                type: BottomNavigationBarType.fixed,
                currentIndex: 2, // Library index in bottom bar
                onTap: (index) {
                  // Handle library screen navigation
                },
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: 'HOME'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.search), label: 'SEARCH'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.explore_outlined), label: 'LIBRARY')
                ],
              ),
        body: Stack(
          children: [
            // Main Content Area
            Positioned.fill(
              child: isBigScreen
                  ? _buildBigScreenLayout()
                  : _buildSmallScreenLayout(),
            ),

            // Mini Player Overlay at the bottom
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: PlayNowScreen(
                selectedSongIndex: _selectedSongIndex,
                isBigScreen: isBigScreen,
                songs: _songs,
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
    return TextField(
        textInputAction: TextInputAction.search,
        style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.0),
        decoration: InputDecoration(
          fillColor: const Color(0xFF161B22),
          filled: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.cyanAccent.shade400, width: 1),
          ),
          hintText: "SEARCH...",
          hintStyle: TextStyle(
              color: Colors.grey[600],
              fontSize: 13,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.5),
          prefixIcon: Icon(Icons.search, color: Colors.grey[600], size: 18),
        ));
  }

  Widget _buildStatsAndButtonsRow() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      color: Colors.transparent,
      child: Row(
        children: [
          Text("${_songs.length} TRACKS",
              style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.0)),
          const Spacer(),
          _buildActionButton(
              Icons.shuffle,
              "SHUFFLE",
              Colors.cyanAccent.shade400.withValues(alpha: 0.1),
              Colors.cyanAccent.shade400),
          const SizedBox(width: 8),
          _buildActionButton(
              Icons.play_arrow,
              "PLAY ALL",
              Colors.cyanAccent.shade400.withValues(alpha: 0.1),
              Colors.cyanAccent.shade400),
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

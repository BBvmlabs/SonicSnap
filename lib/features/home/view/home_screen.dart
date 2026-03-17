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

enum NavState { library, artist, laboratory, queue, search }

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isPlaying = false;
  bool isPlayerExpanded = false;
  bool isBigScreen = false;
  int _selectedSongIndex = 0;
  NavState _currentNav = NavState.library;

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
      "assets/logo/logo.png",
      width: width,
    );
  }

  Widget _buildTabBar() {
    return Container(
      color: Colors.black,
      child: TabBar(
        controller: _tabController,
        isScrollable: true,
        indicatorWeight: 3,
        labelColor: Colors.purpleAccent,
        unselectedLabelColor: Colors.grey,
        labelStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Theme.of(context).primaryColor,
            ),
        tabs: const [
          Tab(text: "Tracks"),
          Tab(text: "Downloads"),
          Tab(text: "Albums"),
          Tab(text: "Artists"),
        ],
      ),
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
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverAppBar(
            backgroundColor: Colors.black,
            expandedHeight: 120,
            floating: false,
            pinned: true,
            elevation: 0,
            title: _buildLogo(170),
            centerTitle: false,
            actions: [_buildActions()],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(48),
              child: _buildTabBar(),
            ),
          ),
        ];
      },
      body: Column(
        children: [
          _buildSearchZone(),
          _buildStatsAndButtonsRow(),
          _buildSongList(),
        ],
      ),
    );
  }

  Widget _buildBigScreenLayout() {
    return Row(
      children: [
        // 1. Fixed Sidebar Navigation
        _buildSidebar(),

        // 2. Main Content Area
        Expanded(
          child: _buildMainContent(),
        ),
      ],
    );
  }

  Widget _buildMainContent() {
    switch (_currentNav) {
      case NavState.library:
        return Column(
          children: [
            _buildTopUtilityBar(),
            _buildLibraryHeader(),
            _buildTableHeadings(),
            const Divider(
                height: 1, color: Colors.white10, indent: 32, endIndent: 32),
            Expanded(child: _buildSongTable()),
          ],
        );
      case NavState.artist:
        return _buildArtistView();
      case NavState.laboratory:
        return _buildLaboratoryView();
      case NavState.queue:
        return _buildQueueView();
      case NavState.search:
        return _buildSearchView();
    }
  }

  Widget _buildSidebar() {
    return Container(
      width: 260,
      color: const Color(0xFF080C11),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 48),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'VIBEENGINE',
                  style: TextStyle(
                    color: Colors.cyanAccent.shade400,
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2.0,
                  ),
                ),
                Text(
                  'SONIC LABORATORY',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 3.0,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 72),
          _buildSidebarItem(
              Icons.home_outlined, 'HOME', _currentNav == NavState.library, () {
            setState(() => _currentNav = NavState.library);
          }),
          _buildSidebarItem(Icons.explore_outlined, 'DISCOVERY',
              _currentNav == NavState.artist, () {
            setState(() => _currentNav = NavState.artist);
          }),
          _buildSidebarItem(Icons.science_outlined, 'LABORATORY',
              _currentNav == NavState.laboratory, () {
            setState(() => _currentNav = NavState.laboratory);
          }),
          _buildSidebarItem(Icons.queue_music_outlined, 'QUEUE',
              _currentNav == NavState.queue, () {
            setState(() => _currentNav = NavState.queue);
          }),
          _buildSidebarItem(
              Icons.search_outlined, 'SEARCH', _currentNav == NavState.search,
              () {
            setState(() => _currentNav = NavState.search);
          }),
          const Spacer(),
          _buildSidebarItem(Icons.settings_outlined, 'SETTINGS', false, () {}),
          _buildSidebarItem(
              Icons.help_outline_rounded, 'SUPPORT', false, () {}),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildSidebarItem(
      IconData icon, String label, bool isSelected, VoidCallback onTap) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        border: isSelected
            ? Border(
                left: BorderSide(
                  color: Colors.cyanAccent.shade400,
                  width: 4,
                ),
              )
            : null,
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 32),
        leading: Icon(
          icon,
          color: isSelected ? Colors.cyanAccent.shade400 : Colors.grey[600],
          size: 22,
        ),
        title: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.cyanAccent.shade400 : Colors.grey[600],
            fontSize: 12,
            fontWeight: FontWeight.w800,
            letterSpacing: 2.0,
          ),
        ),
        dense: true,
        tileColor: isSelected
            ? Colors.cyanAccent.shade400.withValues(alpha: 0.05)
            : null,
      ),
    );
  }

  Widget _buildTopUtilityBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 32, 40, 0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 44,
              decoration: BoxDecoration(
                color: const Color(0xFF161B22).withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(4),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'SEARCH LABORATORY FILES...',
                  hintStyle: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 11,
                      letterSpacing: 1.2),
                  prefixIcon:
                      Icon(Icons.search, size: 20, color: Colors.grey[800]),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 11),
                ),
                style: const TextStyle(color: Colors.white, fontSize: 13),
              ),
            ),
          ),
          const SizedBox(width: 32),
          Icon(Icons.cast_connected,
              color: Colors.cyanAccent.shade400, size: 22),
          const SizedBox(width: 32),
          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white10, width: 1),
            ),
            child: const CircleAvatar(
              radius: 16,
              backgroundImage: NetworkImage('https://via.placeholder.com/150'),
              backgroundColor: Color(0xFF161B22),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLibraryHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 56, 40, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
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
                    Icon(Icons.tune_rounded, color: Colors.grey[600], size: 16),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
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
          Expanded(
              flex: 5, child: Text('TRACK DETAILS', style: _headingStyle)),
          Expanded(flex: 3, child: Text('ALBUM', style: _headingStyle)),
          Expanded(
              flex: 2, child: Text('DURATION', style: _headingStyle)),
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
                      color: isSelected ? Colors.cyanAccent : Colors.grey[800],
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
                                  ? Colors.cyanAccent
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
                      _buildTag('FLAC'),
                      const SizedBox(width: 8),
                      _buildTag('24-BIT', color: Colors.purple.shade900),
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

  Widget _buildTag(String label, {Color? color}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: color ?? Colors.teal.shade900.withValues(alpha: 0.3),
        border: Border.all(color: Colors.white10),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white38,
          fontSize: 9,
          fontWeight: FontWeight.w900,
          letterSpacing: 1.0,
        ),
      ),
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
              Colors.purpleAccent.withValues(alpha: 0.1), Colors.purpleAccent),
          const SizedBox(width: 8),
          _buildActionButton(Icons.play_arrow, "Play All",
              Colors.purpleAccent.withValues(alpha: 0.1), Colors.purpleAccent),
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

  Widget _buildArtistView() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Artist Hero Section
          Stack(
            children: [
              Container(
                height: 450,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(_songs[0]['image']),
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  ),
                ),
                foregroundDecoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.2),
                      Colors.black.withValues(alpha: 0.8),
                      const Color(0xFF0D1117),
                    ],
                    stops: const [0.0, 0.6, 1.0],
                  ),
                ),
              ),
              Positioned(
                left: 40,
                bottom: 60,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.cyanAccent.shade700
                                .withValues(alpha: 0.2),
                            border:
                                Border.all(color: Colors.cyanAccent.shade400),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Row(
                            children: [
                              Text('VERIFIED ARTIST',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 9,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(width: 8),
                              Icon(Icons.check_circle,
                                  color: Colors.cyanAccent, size: 12),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'The Prodigy',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 84,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          '2.4M MONTHLY LISTENERS',
                          style: TextStyle(
                            color: Colors.cyanAccent.shade400,
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 2.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Container(
                              width: 3, height: 3, color: Colors.grey[700]),
                        ),
                        Text(
                          'Braintree, Essex, UK',
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    Row(
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.play_arrow_rounded, size: 28),
                          label: const Text('SHUFFLE PLAY'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.cyanAccent.shade400,
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 20),
                            textStyle: const TextStyle(
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1.5,
                                fontSize: 13),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                          ),
                        ),
                        const SizedBox(width: 16),
                        OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.white10),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 20),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                          ),
                          child: const Text('FOLLOW',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 1.5,
                                  fontSize: 13)),
                        ),
                        const SizedBox(width: 16),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.share_outlined,
                              color: Colors.white, size: 24),
                          padding: const EdgeInsets.all(16),
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.white10,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Content Tabs (Mocking the Discography layout)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Tracks
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Top Tracks',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              'VIEW ALL',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          final song = _songs[index % _songs.length];
                          return _buildArtistTrackItem(index + 1, song);
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 60),
                // Discography
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Discography',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              'SEE DISCOGRAPHY',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                          childAspectRatio: 0.75,
                        ),
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return _buildAlbumCard(index);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 150),
        ],
      ),
    );
  }

  Widget _buildArtistTrackItem(int index, Map<String, dynamic> song) {
    return Container(
      height: 80,
      margin: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          SizedBox(
            width: 40,
            child: Text(
              index.toString().padLeft(2, '0'),
              style: TextStyle(color: Colors.grey[800], fontSize: 12),
            ),
          ),
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              image: DecorationImage(
                image: AssetImage(song['image']),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  song['title'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  'THE FAT OF THE LAND',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              _buildTag('FLAC'),
              const SizedBox(width: 8),
              if (index % 2 == 0)
                _buildTag('24-BIT', color: Colors.purple.shade900),
            ],
          ),
          const SizedBox(width: 40),
          Text(
            '382,102,492',
            style: TextStyle(color: Colors.grey[700], fontSize: 12),
          ),
          const SizedBox(width: 40),
          Text(
            song['duration'],
            style: TextStyle(color: Colors.grey[700], fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildAlbumCard(int index) {
    final titles = [
      "The Fat of the Land",
      "Experience",
      "Always Outnumbered",
      "Invaders Must Die"
    ];
    final years = ["1997", "1992", "2004", "2009"];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: AssetImage(_songs[index % _songs.length]['image']),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          titles[index],
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        Text(
          '${years[index]} • ALBUM',
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 11,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
          ),
        ),
      ],
    );
  }

  Widget _buildLaboratoryView() {
    final song = _songs[_selectedSongIndex];
    return Column(
      children: [
        // Top Bar
        Padding(
          padding: const EdgeInsets.fromLTRB(40, 32, 40, 0),
          child: Row(
            children: [
              Row(
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                        color: Colors.cyanAccent, shape: BoxShape.circle),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'SYSTEM ONLINE',
                    style: TextStyle(
                      color: Colors.cyanAccent.shade400,
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2.0,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              _buildLaboratorySearch(),
              const SizedBox(width: 32),
              const Icon(Icons.notifications_outlined,
                  color: Colors.white70, size: 20),
              const SizedBox(width: 24),
              const Icon(Icons.bar_chart_rounded,
                  color: Colors.white70, size: 20),
              const SizedBox(width: 24),
              const Icon(Icons.account_circle_outlined,
                  color: Colors.white70, size: 20),
            ],
          ),
        ),

        // Main Player Content
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Album Art with Glow
                Container(
                  width: 400,
                  height: 400,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: AssetImage(song['image']),
                      fit: BoxFit.cover,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.5),
                        blurRadius: 40,
                        spreadRadius: 10,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 64),
                // Title and Artist
                Text(
                  song['title'].toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 48,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -1,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'NEURAL NETWORK × VOID_RUNNER',
                  style: TextStyle(
                    color: Colors.cyanAccent.shade400,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 48),
                // Technical Metadata Row
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF161B22).withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildTechTag('FORMAT', 'FLAC'),
                      _buildTechDivider(),
                      _buildTechTag('BITRATE', '1411 KBPS'),
                      _buildTechDivider(),
                      _buildTechTag('SAMPLE RATE', '44.1 KHZ'),
                    ],
                  ),
                ),
                const SizedBox(height: 64),
                // Visualizer
                _buildBarVisualizer(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLaboratorySearch() {
    return Container(
      width: 300,
      height: 40,
      decoration: BoxDecoration(
        color: const Color(0xFF161B22).withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(4),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'SEARCH FREQUENCY...',
          hintStyle: TextStyle(
              color: Colors.grey[800], fontSize: 10, letterSpacing: 1.2),
          suffixIcon: Icon(Icons.search, size: 16, color: Colors.grey[800]),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }

  Widget _buildTechTag(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 9,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }

  Widget _buildTechDivider() {
    return Container(
      height: 24,
      width: 1,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      color: Colors.white10,
    );
  }

  Widget _buildBarVisualizer() {
    return SizedBox(
      height: 80,
      width: 600,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(40, (index) {
          final height = (index % 5 + 1) * 10.0 + (index % 3) * 15.0;
          return Container(
            width: 8,
            height: height,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              color: index == 15 || index == 30
                  ? Colors.cyanAccent
                  : Colors.cyanAccent.shade700.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildQueueView() {
    final nowPlaying = _songs[_selectedSongIndex];
    return Row(
      children: [
        // Main Queue Content
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Play Queue',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 48,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'LABORATORY SESSION 04: SEQUENCE',
                          style: TextStyle(
                            color: Colors.cyanAccent.shade400,
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 2.0,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.white10),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 16),
                          ),
                          child: const Text('CLEAR QUEUE',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(width: 16),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.cyanAccent.shade400,
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 16),
                          ),
                          child: const Text('SAVE PLAYLIST',
                              style: TextStyle(
                                  fontSize: 11, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 64),
                // Now Playing Card
                Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: const Color(0xFF161B22).withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white10),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 280,
                        height: 280,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: AssetImage(nowPlaying['image']),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 48),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                _buildTag('NOW PLAYING',
                                    color: Colors.purple.shade900),
                                const SizedBox(width: 12),
                                _buildTag('HI-RES 192KHZ'),
                              ],
                            ),
                            const SizedBox(height: 24),
                            Text(
                              nowPlaying['title'].toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 64,
                                fontWeight: FontWeight.w900,
                                letterSpacing: -1,
                              ),
                            ),
                            Text(
                              'ARCHITECTS OF VOID',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 2.0,
                              ),
                            ),
                            const SizedBox(height: 48),
                            _buildBarVisualizer(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 64),
                // Up Next Section
                const Text(
                  'UP NEXT',
                  style: TextStyle(
                    color: Colors.white24,
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 4.0,
                  ),
                ),
                const SizedBox(height: 32),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    final song = _songs[(index + 1) % _songs.length];
                    return _buildNextTrackItem(song);
                  },
                ),
              ],
            ),
          ),
        ),
        // Right Panel (Playlists/History)
        Container(
          width: 300,
          decoration: const BoxDecoration(
            border: Border(left: BorderSide(color: Colors.white10)),
          ),
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'SAVED PLAYLISTS',
                style: TextStyle(
                  color: Colors.cyanAccent,
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2.0,
                ),
              ),
              const SizedBox(height: 24),
              _buildRightPanelItem(Icons.science_outlined, 'LABORATORY_MIX_01'),
              _buildRightPanelItem(
                  Icons.nights_stay_outlined, 'NIGHT_DRIVE_NEURAL'),
              _buildRightPanelItem(Icons.waves_rounded, 'PRECISION_FOCUS'),
              const SizedBox(height: 48),
              const Text(
                'HISTORY',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2.0,
                ),
              ),
              const SizedBox(height: 24),
              _buildHistoryItem(_songs[1], '24 MINS AGO'),
              _buildHistoryItem(_songs[2], '1 HOUR AGO'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNextTrackItem(Map<String, dynamic> song) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.02),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(Icons.drag_indicator_rounded, color: Colors.white12),
          const SizedBox(width: 24),
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              image: DecorationImage(
                image: AssetImage(song['image']),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  song['title'].toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  'LOOMING STATIC',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          _buildTag('FLAC'),
          const SizedBox(width: 32),
          Text(
            song['duration'] ?? '04:12',
            style: TextStyle(color: Colors.grey[600], fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _buildRightPanelItem(IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Icon(icon, color: Colors.white70, size: 18),
          ),
          const SizedBox(width: 16),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 11,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryItem(Map<String, dynamic> song, String time) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              image: DecorationImage(
                image: AssetImage(song['image']),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                song['title'].toUpperCase(),
                style: const TextStyle(
                  color: Colors.white54,
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                time,
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchView() {
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
                    _buildDomainCard('TECHNO', '128-145 BPM',
                        _songs[0]['image'], Colors.purple.shade900, true),
                    _buildDomainCard('AMBIENT', null, _songs[1]['image'],
                        Colors.teal.shade900, false),
                    _buildDomainCard('INDUSTRIAL', null, _songs[2]['image'],
                        Colors.blueGrey.shade900, false),
                    _buildDomainCard('PHONK', null, _songs[3]['image'],
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

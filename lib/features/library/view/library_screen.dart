import 'package:flutter/material.dart';
import 'package:sonic_snap/features/album/view/album_screen.dart';
import 'package:sonic_snap/features/artist/view/artist_screen.dart';
import 'package:sonic_snap/features/playlist/view/playlist_screen.dart';
import 'package:sonic_snap/features/tracks/view/tracks_list.dart';
import 'package:sonic_snap/widgets/title_bar.dart';

class libraryScreen extends StatefulWidget {
  const libraryScreen({super.key});

  @override
  State<libraryScreen> createState() => _libraryScreenState();
}

class _libraryScreenState extends State<libraryScreen>
    with SingleTickerProviderStateMixin {
  bool isPlaying = false;
  bool isPlayerExpanded = false;
  bool isBigScreen = false;
  late final TabController _tabController =
      TabController(length: 4, vsync: this);

  List<Widget> tabs = [
    const AlbumScreen(),
    const TracksListScreen(),
    const ArtistScreen(),
    const PlaylistScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    isBigScreen = MediaQuery.of(context).size.width >
        900; // Increased threshold for wide layout
    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildTitleBar("LIBRARY", isSmallScreen: true),
            TabBar(
              controller: _tabController,
              isScrollable: !isBigScreen,
              tabAlignment:
                  !isBigScreen ? TabAlignment.start : TabAlignment.fill,
              dividerColor: Colors.transparent,
              labelStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w800),
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: const [
                Tab(
                  text: 'Albums',
                ),
                Tab(
                  text: 'Tracks',
                ),
                Tab(
                  text: 'Artists',
                ),
                Tab(
                  text: 'Playlists',
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: tabs,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

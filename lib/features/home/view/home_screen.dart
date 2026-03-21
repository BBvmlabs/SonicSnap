import 'package:flutter/material.dart';
import 'package:sonic_snap/features/album/view/album_screen.dart';
import 'package:sonic_snap/features/artist/view/artist_list_view.dart';
import 'package:sonic_snap/data/dummy_data.dart';
import 'package:sonic_snap/features/home/view/home_content.dart';
import 'package:sonic_snap/features/menu/view/sidebar.dart';
import 'package:sonic_snap/features/music/view/play_now.dart';
import 'package:sonic_snap/features/music/view/search_screen.dart';
import 'package:sonic_snap/features/settings/view/settings_screen.dart';
import 'package:sonic_snap/features/tracks/view/tracks_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum NavState { home, album, artist, tracks, playlists, settings }

enum MobileNavState { home, search, library }

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  bool isPlaying = false;
  bool isPlayerExpanded = false;
  bool isBigScreen = false;
  int _selectedScreenIndex = 0;
  int _selectedSongIndex = 0;
  NavState _currentNav = NavState.home;

  void _nextSong() {
    setState(() {
      _selectedSongIndex = (_selectedSongIndex + 1) % dummySongs.length;
    });
  }

  void _previousSong() {
    setState(() {
      _selectedSongIndex =
          (_selectedSongIndex - 1 + dummySongs.length) % dummySongs.length;
    });
  }

  void _togglePlayer() {
    setState(() {
      isPlayerExpanded = !isPlayerExpanded;
    });
  }

  Widget _buildMobileScreenLayout() {
    switch (MobileNavState.values[_selectedScreenIndex]) {
      case MobileNavState.home:
        return const HomeContent();
      case MobileNavState.search:
        return const SearchScreen();
      case MobileNavState.library:
        return const TracksListScreen();
    }
  }

  Widget _buildBigScreenLayout() {
    return Row(
      children: [
        // 1. Fixed Sidebar Navigation
        Sidebar(
          currentNav: _currentNav,
          onNavChanged: (nav) {
            setState(() {
              _currentNav = nav;
            });
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
      case NavState.home:
        return const HomeContent();
      case NavState.album:
        return const AlbumScreen();
      case NavState.artist:
        return const ArtistListView();
      case NavState.tracks:
        return const TracksListScreen();
      case NavState.playlists:
        return const AlbumScreen();
      case NavState.settings:
        return const SettingsScreen();
    }
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
                currentIndex: _selectedScreenIndex,
                onTap: (index) {
                  setState(() {
                    _selectedScreenIndex = index;
                  });
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
                    : _buildMobileScreenLayout()),

            // Mini Player Overlay at the bottom
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: PlayNowScreen(
                selectedSongIndex: _selectedSongIndex,
                isBigScreen: isBigScreen,
                songs: dummySongs,
                isExpanded: isPlayerExpanded,
                title: dummySongs[_selectedSongIndex]['title'],
                image: dummySongs[_selectedSongIndex]['image'],
                description: dummySongs[_selectedSongIndex]['artist'],
                isPlaying: isPlaying,
                onTap: _togglePlayer,
                onPlayPause: () {
                  setState(() {
                    isPlaying = !isPlaying;
                  });
                },
                onPrevious: _previousSong,
                onNext: _nextSong,
                color: dummySongs[_selectedSongIndex]['color'],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

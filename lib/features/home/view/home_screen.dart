import 'package:flutter/material.dart';
import 'package:sonic_snap/features/album/view/album_screen.dart';
import 'package:sonic_snap/features/artist/view/artist_screen.dart';
import 'package:sonic_snap/features/home/view/home_content.dart';
import 'package:sonic_snap/features/library/view/library_screen.dart';
import 'package:sonic_snap/features/menu/view/sidebar.dart';
import 'package:sonic_snap/features/music/view/play_now.dart';
import 'package:sonic_snap/features/music/view/search_screen.dart';
import 'package:sonic_snap/features/playlist/view/playlist_screen.dart';
import 'package:sonic_snap/features/settings/view/settings_screen.dart';
import 'package:sonic_snap/features/tracks/view/tracks_list.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sonic_snap/core/providers/audio_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

enum NavState { home, album, artist, tracks, playlists, settings }

enum MobileNavState { home, search, library }

class _HomeScreenState extends ConsumerState<HomeScreen>
    with SingleTickerProviderStateMixin {
  bool isBigScreen = false;
  int _selectedScreenIndex = 0;
  NavState _currentNav = NavState.home;

  Widget _buildMobileScreenLayout() {
    switch (MobileNavState.values[_selectedScreenIndex]) {
      case MobileNavState.home:
        return const HomeContent();
      case MobileNavState.search:
        return const SearchScreen();
      case MobileNavState.library:
        return const libraryScreen();
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
        return const ArtistScreen();
      case NavState.tracks:
        return const TracksListScreen();
      case NavState.playlists:
        return const PlaylistScreen();
      case NavState.settings:
        return const SettingsScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    final audioState = ref.watch(audioProvider);
    isBigScreen = MediaQuery.of(context).size.width >
        900; // Increased threshold for wide layout
    return PopScope(
      canPop: !audioState.isPlayerExpanded,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        ref.read(audioProvider.notifier).togglePlayer();
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
              child: (audioState.playlist.isNotEmpty && audioState.selectedSongIndex >= 0 && audioState.selectedSongIndex < audioState.playlist.length) ? PlayNowScreen(
                selectedSongIndex: audioState.selectedSongIndex,
                isBigScreen: isBigScreen,
                songs: audioState.playlist,
                isExpanded: audioState.isPlayerExpanded,
                title: audioState.playlist[audioState.selectedSongIndex]['title'] ?? 'Unknown',
                image: audioState.playlist[audioState.selectedSongIndex]['image'] ?? 'assets/logo/play_now.png',
                description: audioState.playlist[audioState.selectedSongIndex]['artist'] ?? 'Unknown Artist',
                isPlaying: audioState.isPlaying,
                onTap: () => ref.read(audioProvider.notifier).togglePlayer(),
                onPlayPause: () => ref.read(audioProvider.notifier).togglePlayPause(),
                onPrevious: () => ref.read(audioProvider.notifier).previousSong(),
                onNext: () => ref.read(audioProvider.notifier).nextSong(),
                color: audioState.playlist[audioState.selectedSongIndex]['color'] ?? Colors.cyanAccent,
              ) : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}

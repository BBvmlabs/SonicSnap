import 'package:flutter/material.dart';
import 'package:sonic_snap/data/dummy_data.dart';
import 'package:sonic_snap/features/music/widgets/widgets.dart';
import 'package:sonic_snap/features/music/widgets/bottom_sheets.dart';
import 'package:sonic_snap/routes/navigator.dart';
import 'package:sonic_snap/routes/router.dart';
import 'package:sonic_snap/widgets/build_tag.dart';
import 'package:sonic_snap/widgets/title_bar.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sonic_snap/core/providers/audio_provider.dart';

class TracksListScreen extends ConsumerStatefulWidget {
  const TracksListScreen({super.key});

  @override
  ConsumerState<TracksListScreen> createState() => _TracksListScreenState();
}

class _TracksListScreenState extends ConsumerState<TracksListScreen> {
  void _navigateToAlbum(Map<String, dynamic> song) {
    navigate(context, AppRouter.albumDetailsScreen, extra: {
      'title': "The Fat of the Land",
      'artist': "The Prodigy",
      'image': song['image'],
    });
  }

  void _navigateToArtist(Map<String, dynamic> song) {
    navigate(context, AppRouter.artistDetailsScreen, extra: {
      'title': "The Fat of the Land",
      'artist': "The Prodigy",
      'image': song['image'],
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isBigScreen = MediaQuery.of(context).size.width > 900;

    // Returning pure content so it nests properly inside the main scaffolding
    if (isBigScreen) {
      return Column(
        children: [
          buildTitleBar("TRACKS"),
          _buildTableHeadings(),
          const Divider(
              height: 1, color: Colors.white10, indent: 32, endIndent: 32),
          Expanded(child: _buildSongTable(isBigScreen)),
        ],
      );
    } else {
      return Column(
        children: [
          buildMobileTitleBar(context, Icons.music_note, 'TRACKS'),
          _buildStatsAndButtonsRow(),
          Expanded(child: _buildSongList()),
        ],
      );
    }
  }

  // Big Screen Table
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

  Widget _buildSongTable(bool isBigScreen) {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 150),
      itemCount: dummySongs.length,
      itemBuilder: (context, index) {
        final song = dummySongs[index];
        final audioState = ref.watch(audioProvider);
        final isSelected = audioState.selectedSongIndex == index;
        return GestureDetector(
          onTap: () {
            ref.read(audioProvider.notifier).playSong(index);
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

  // Mobile Song List
  Widget _buildStatsAndButtonsRow() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      color: Colors.transparent,
      child: Row(
        children: [
          Text("${dummySongs.length} TRACKS",
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
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 100),
      itemCount: dummySongs.length,
      itemBuilder: (context, index) {
        final song = dummySongs[index];
        final audioState = ref.watch(audioProvider);
        return SongCard(
          title: song['title'],
          artist: song['artist'],
          imageUrl: song['image'],
          color: song['color'],
          duration: song['duration'] ?? "3:45",
          isSelected: audioState.selectedSongIndex == index,
          isPlaying: audioState.isPlaying && audioState.selectedSongIndex == index,
          onTap: () {
            ref.read(audioProvider.notifier).playSong(index);
          },
          onMore: () {
            showSongOptionsSheet(
              context,
              song,
              onAlbumTap: () => _navigateToAlbum(song),
              onArtistTap: () => _navigateToArtist(song),
            );
          },
        );
      },
    );
  }
}

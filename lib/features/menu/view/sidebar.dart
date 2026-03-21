import 'package:flutter/material.dart';
import 'package:sonic_snap/features/home/view/home_screen.dart';
import 'package:sonic_snap/widgets/app_logo.dart';

class Sidebar extends StatelessWidget {
  final NavState currentNav;
  final Function(NavState) onNavChanged;

  const Sidebar({
    super.key,
    required this.currentNav,
    required this.onNavChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      color: const Color(0xFF080C11),
      child: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: insideAppLogo(350),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  child: Text(
                    "PLUG INTO THE SOUNDSCAPE",
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontSize: 12,
                          letterSpacing: 3,
                          color: Colors.white24,
                          fontWeight: FontWeight.w900,
                        ),
                  ),
                ),
                const Spacer(),
                _buildSidebarItem(
                    Icons.home_outlined, 'Home', currentNav == NavState.home,
                    () {
                  onNavChanged(NavState.home);
                }),
                _buildSidebarItem(
                    Icons.album_outlined, 'Album', currentNav == NavState.album,
                    () {
                  onNavChanged(NavState.album);
                }),
                _buildSidebarItem(Icons.library_music_outlined, 'Tracks',
                    currentNav == NavState.tracks, () {
                  onNavChanged(NavState.tracks);
                }),
                _buildSidebarItem(Icons.explore_outlined, 'Artist',
                    currentNav == NavState.artist, () {
                  onNavChanged(NavState.artist);
                }),
                _buildSidebarItem(Icons.queue_music_outlined, 'Playlists',
                    currentNav == NavState.playlists, () {
                  onNavChanged(NavState.playlists);
                }),
                const Spacer(),
                _buildSidebarItem(
                    Icons.settings_outlined, 'SETTINGS', false, () {}),
                _buildSidebarItem(
                    Icons.help_outline_rounded, 'SUPPORT', false, () {}),
                const SizedBox(height: 100),
              ],
            ),
          ),
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
}

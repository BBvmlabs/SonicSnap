import 'package:flutter/material.dart';
import 'package:sonic_snap/features/home/view/home_screen.dart';

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
              Icons.home_outlined, 'Home', currentNav == NavState .library, () {
            onNavChanged(NavState.library);
          }),
          _buildSidebarItem(
              Icons.album_outlined, 'Album', currentNav == NavState.artist, () {
            onNavChanged(NavState.artist);
          }),
          _buildSidebarItem(Icons.library_music_outlined, 'Tracks',
              currentNav == NavState.library, () {
            onNavChanged(NavState.library);
          }),
          _buildSidebarItem(
              Icons.explore_outlined, 'Artist', currentNav == NavState.artist,
              () {
            onNavChanged(NavState.artist);
          }),
          _buildSidebarItem(
              Icons.queue_music_outlined, 'Queue', currentNav == NavState.queue,
              () {
            onNavChanged(NavState.queue);
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
}

import 'package:flutter/material.dart';
import 'package:sonic_snap/routes/router.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1117), // Deep dark/black
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D1117),
        elevation: 0,
        centerTitle: true,
        title: const Text("Settings",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("CONFIGURATION",
                style: TextStyle(
                    color: Colors.tealAccent,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2)),
            const SizedBox(height: 8),
            const Text("System\nPreferences",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    height: 1.1)),
            const SizedBox(height: 32),
            _buildSectionHeader(Icons.graphic_eq, "AUDIO ENGINE"),
            const SizedBox(height: 16),
            _buildSettingsCard([
              _buildTile(
                context,
                icon: Icons.graphic_eq,
                title: "Audio Quality",
                subtitle: "High-Res (24bit / 192kHz)",
                onTap: () {},
              ),
              _buildDivider(),
              _buildTile(
                context,
                icon: Icons.tune,
                title: "Equalizer",
                subtitle: "Custom preset enabled",
                onTap: () => navigate(context, AppRouter.equalizerScreen),
              ),
              _buildDivider(),
              _buildSwitchTile(
                icon: Icons.queue_music,
                title: "Gapless Playback",
                value: true,
                onChanged: (v) {},
              ),
            ]),
            const SizedBox(height: 24),
            _buildSectionHeader(Icons.view_quilt, "INTERFACE"),
            const SizedBox(height: 16),
            _buildSettingsCard([
              _buildTile(
                context,
                icon: Icons.palette,
                title: "UI Themes",
                subtitle: "Cyberpunk Dark",
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                        width: 12,
                        height: 12,
                        decoration: const BoxDecoration(
                            color: Color(0xFF0D1117), shape: BoxShape.circle)),
                    const SizedBox(width: 4),
                    Container(
                        width: 12,
                        height: 12,
                        decoration: const BoxDecoration(
                            color: Colors.tealAccent, shape: BoxShape.circle)),
                    const SizedBox(width: 4),
                    Container(
                        width: 12,
                        height: 12,
                        decoration: const BoxDecoration(
                            color: Colors.purpleAccent,
                            shape: BoxShape.circle)),
                    const SizedBox(width: 8),
                    const Icon(Icons.chevron_right,
                        color: Colors.grey, size: 20),
                  ],
                ),
                onTap: () {},
              ),
              _buildDivider(),
              _buildTile(
                context,
                icon: Icons.album,
                title: "Player Appearance",
                subtitle: null,
                onTap: () {},
              ),
            ]),
            const SizedBox(height: 24),
            _buildSectionHeader(Icons.folder_open, "CONTENT"),
            const SizedBox(height: 16),
            _buildSettingsCard([
              _buildTile(
                context,
                icon: Icons.folder,
                title: "Library Folders",
                subtitle: "3 paths watched",
                onTap: () => navigate(context, AppRouter.storageScreen),
              ),
            ]),
            const SizedBox(height: 24),
            _buildSettingsCard([
              _buildTile(
                context,
                icon: Icons.info,
                title: "About",
                subtitle: null,
                trailing: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(4)),
                  child: const Text("v2.4.0",
                      style: TextStyle(color: Colors.grey, fontSize: 12)),
                ),
                onTap: () {},
              ),
            ]),
            const SizedBox(height: 48),
            const Center(
                child: Text("Built with Poweramp DNA & Samsung Clarity",
                    style: TextStyle(color: Colors.white24, fontSize: 12))),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(IconData icon, String title) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey, size: 16),
        const SizedBox(width: 8),
        Text(title,
            style: const TextStyle(
                color: Colors.grey,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.1)),
      ],
    );
  }

  Widget _buildSettingsCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF161B22), // Light card bg
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildTile(BuildContext context,
      {required IconData icon,
      required String title,
      String? subtitle,
      Widget? trailing,
      required VoidCallback onTap}) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: const Color(0xFF0D1117), // Icon bg
          borderRadius: BorderRadius.circular(20), // Circle
        ),
        child: Icon(icon, color: Colors.tealAccent, size: 20),
      ),
      title: Text(title,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
      subtitle: subtitle != null
          ? Text(subtitle,
              style: const TextStyle(color: Colors.grey, fontSize: 12))
          : null,
      trailing: trailing ??
          const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
    );
  }

  Widget _buildSwitchTile(
      {required IconData icon,
      required String title,
      required bool value,
      required ValueChanged<bool> onChanged}) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: const Color(0xFF0D1117),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(icon, color: Colors.tealAccent, size: 20),
      ),
      title: Text(title,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: Colors.black,
        activeTrackColor: Colors.tealAccent,
        inactiveThumbColor: Colors.grey,
        inactiveTrackColor: Colors.grey[800],
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(height: 1, color: Colors.white10);
  }
}

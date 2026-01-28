import 'package:flutter/material.dart';

// --- Contextual Menu (Three dots) ---
void showSongOptionsSheet(BuildContext context, Map<String, dynamic> song,
    {VoidCallback? onAlbumTap}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) => _SongOptionsSheet(song: song, onAlbumTap: onAlbumTap),
  );
}

class _SongOptionsSheet extends StatelessWidget {
  final Map<String, dynamic> song;
  final VoidCallback? onAlbumTap;

  const _SongOptionsSheet({required this.song, this.onAlbumTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0F0F0F),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        border: Border.all(color: Colors.white10),
      ),
      padding: const EdgeInsets.only(top: 8, bottom: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(2))),

          const SizedBox(height: 20),

          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                      song['image'] ?? "assets/logo/play_now.png",
                      width: 56,
                      height: 56,
                      fit: BoxFit.cover),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(song['title'] ?? "Unknown Title",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(song['artist'] ?? "Unknown Artist",
                              style: const TextStyle(
                                  color: Colors.blueAccent, fontSize: 14)),
                          const SizedBox(width: 8),
                          _buildTag("FLAC"),
                          const SizedBox(width: 4),
                          _buildTag("24BIT"),
                        ],
                      )
                    ],
                  ),
                ),
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: IconButton(
                      icon: const Icon(Icons.share, color: Colors.white),
                      onPressed: () {}),
                )
              ],
            ),
          ),

          const SizedBox(height: 24),
          const Divider(color: Colors.white10, height: 1),

          // Options
          _buildOption(Icons.playlist_play, "Play Next", onTap: () {}),
          _buildOption(Icons.queue_music, "Add to Queue", onTap: () {}),
          _buildOption(Icons.add_circle_outline, "Add to Playlist", onTap: () {
            Navigator.pop(context); // Close current sheet
            showAddToPlaylistSheet(context);
          }),
          _buildOption(Icons.person, "Go to Artist", isLink: true),
          _buildOption(Icons.album, "Go to Album", isLink: true, onTap: () {
            Navigator.pop(context);
            onAlbumTap?.call();
          }),

          const SizedBox(height: 16),

          // Action Buttons Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildCircleAction(Icons.favorite_border, "Like"),
                _buildCircleAction(Icons.notifications_none, "Ringtone"),
                _buildCircleAction(Icons.share, "Share"),
              ],
            ),
          ),

          const SizedBox(height: 16),

          _buildOption(Icons.info_outline, "Song Details", onTap: () {
            Navigator.pop(context);
            showSongDetailsSheet(context, song);
          }, subtitle: "1411kbps • Stereo • 44.1kHz"),

          const SizedBox(height: 16),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E1E1E),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
          color: Colors.white10, borderRadius: BorderRadius.circular(4)),
      child: Text(text,
          style: const TextStyle(
              color: Colors.grey, fontSize: 10, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildOption(IconData icon, String title,
      {bool isLink = false, VoidCallback? onTap, String? subtitle}) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration:
            const BoxDecoration(color: Colors.white10, shape: BoxShape.circle),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
      title: Text(title,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500)),
      subtitle: subtitle != null
          ? Text(subtitle,
              style: const TextStyle(color: Colors.tealAccent, fontSize: 12))
          : null,
      trailing:
          isLink ? const Icon(Icons.chevron_right, color: Colors.grey) : null,
      onTap: onTap,
    );
  }

  Widget _buildCircleAction(IconData icon, String label) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
              color: const Color(0xFF1E1E1E),
              borderRadius: BorderRadius.circular(20)),
          child: Icon(icon, color: Colors.white),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    );
  }
}

// --- Add to Playlist Sheet ---
void showAddToPlaylistSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) => const _AddToPlaylistSheet(),
  );
}

class _AddToPlaylistSheet extends StatelessWidget {
  const _AddToPlaylistSheet();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: const BoxDecoration(
        color: Color(0xFF060F11), // Dark tealish black from screenshot
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 12),
          Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                  color: Colors.teal[900],
                  borderRadius: BorderRadius.circular(2))),

          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 16, 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Add to Playlist",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Cancel",
                        style: TextStyle(color: Colors.tealAccent))),
              ],
            ),
          ),

          // Search
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xFF0F1A1C),
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: Colors.white10),
            ),
            child: const Row(
              children: [
                Icon(Icons.search, color: Colors.grey),
                SizedBox(width: 12),
                Text("Find playlist...", style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Create New
          ListTile(
            leading: Container(
              width: 48,
              height: 48,
              decoration: const BoxDecoration(
                  color: Colors.teal, shape: BoxShape.circle),
              child: const Icon(Icons.add, color: Colors.white),
            ),
            title: const Text("Create New Playlist",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
            trailing: const Icon(Icons.chevron_right, color: Colors.grey),
            onTap: () {},
          ),

          const Divider(color: Colors.white10),

          // List
          Expanded(
            child: ListView(
              children: [
                _buildPlaylist("Favorites", "214 songs • Pinned"),
                _buildPlaylist("Neon Nightrides", "45 songs"),
                _buildPlaylist("Highway Hypnosis", "120 songs"),
                _buildPlaylist("Iron & Bass", "86 songs"),
                _buildPlaylist("Deep Work Flow", "55 songs"),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPlaylist(String title, String subtitle) {
    return ListTile(
      leading: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(12),
          image: const DecorationImage(
              image: AssetImage("assets/logo/play_now.png"), fit: BoxFit.cover),
        ),
      ),
      title: Text(title,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle, style: TextStyle(color: Colors.teal[200])),
      trailing: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
            shape: BoxShape.circle, border: Border.all(color: Colors.teal)),
      ),
    );
  }
}

// --- Song Details Sheet ---
void showSongDetailsSheet(BuildContext context, Map<String, dynamic> song) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) => _SongDetailsSheet(song: song),
  );
}

class _SongDetailsSheet extends StatelessWidget {
  final Map<String, dynamic> song;
  const _SongDetailsSheet({required this.song});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF18122B), // Deep Purple bg
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
              alignment: Alignment.topRight,
              child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white54),
                  onPressed: () => Navigator.pop(context))),
          const Text("Track Details",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),

          // Art
          Container(
            width: 140,
            height: 160,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                  image:
                      AssetImage(song['image'] ?? "assets/logo/play_now.png"),
                  fit: BoxFit.cover),
              border: Border.all(color: Colors.white24, width: 4),
            ),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(4)),
                child: const Text("FLAC",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ),

          const SizedBox(height: 16),
          Text(song['title'] ?? "Unknown",
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold)),
          Text(song['artist'] ?? "Unknown",
              style: const TextStyle(color: Colors.purpleAccent, fontSize: 16)),

          const SizedBox(height: 32),

          Row(
            children: [
              _buildStatBox("BITRATE", "1411 kbps"),
              const SizedBox(width: 16),
              _buildStatBox("SAMPLE RATE", "44.1 kHz"),
            ],
          ),

          const SizedBox(height: 16),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Colors.white10, borderRadius: BorderRadius.circular(16)),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text("FILE SIZE",
                      style: TextStyle(color: Colors.grey, fontSize: 10)),
                  SizedBox(height: 4),
                  Text("32.4 MB",
                      style: TextStyle(color: Colors.white, fontSize: 16))
                ]),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text("DURATION",
                      style: TextStyle(color: Colors.grey, fontSize: 10)),
                  SizedBox(height: 4),
                  Text("4:42",
                      style: TextStyle(color: Colors.white, fontSize: 16))
                ]),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text("TYPE",
                      style: TextStyle(color: Colors.grey, fontSize: 10)),
                  SizedBox(height: 4),
                  Text("Stereo",
                      style: TextStyle(color: Colors.white, fontSize: 16))
                ]),
              ],
            ),
          ),

          const SizedBox(height: 16),

          _buildActionItem(Icons.edit, "Edit Tags"),
          const SizedBox(height: 8),
          _buildActionItem(Icons.smartphone, "Set as Ringtone"),
        ],
      ),
    );
  }

  Widget _buildStatBox(String label, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Colors.white10, borderRadius: BorderRadius.circular(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text(value,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }

  Widget _buildActionItem(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
          color: Colors.white10, borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.purple.withOpacity(0.2),
                  shape: BoxShape.circle),
              child: Icon(icon, color: Colors.purpleAccent, size: 20)),
          const SizedBox(width: 16),
          Text(label,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold)),
          const Spacer(),
          const Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
    );
  }
}

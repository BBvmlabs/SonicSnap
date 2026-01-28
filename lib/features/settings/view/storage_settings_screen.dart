import 'package:flutter/material.dart';

class StorageSettingsScreen extends StatelessWidget {
  const StorageSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      appBar: AppBar(
        title: const Text("Downloads & Storage",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        centerTitle: true,
        backgroundColor: const Color(0xFF0D1117),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Toggle
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: const Color(0xFF161B22),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                          child: Text("Internal Storage",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold))),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: const Center(
                          child: Text("External Drive",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold))),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Usage Card
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFF161B22),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Used Space",
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold)),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                            color: Colors.blueAccent.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8)),
                        child: const Text("35% Full",
                            style: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 12,
                                fontWeight: FontWeight.bold)),
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                  RichText(
                    text: const TextSpan(children: [
                      TextSpan(
                          text: "45",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 48,
                              fontWeight: FontWeight.bold)),
                      TextSpan(
                          text: " GB",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 24,
                              fontWeight: FontWeight.bold)),
                    ]),
                  ),
                  const Align(
                      alignment: Alignment.centerRight,
                      child: Text("of 128 GB",
                          style: TextStyle(color: Colors.grey))),
                  const SizedBox(height: 24),

                  // Progress Bar
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 35,
                            child:
                                Container(height: 8, color: Colors.blueAccent)),
                        Expanded(
                            flex: 15,
                            child: Container(height: 8, color: Colors.grey)),
                        Expanded(
                            flex: 50,
                            child: Container(height: 8, color: Colors.white10)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _LegendItem(color: Colors.blueAccent, label: "Music"),
                      _LegendItem(color: Colors.grey, label: "Other Apps"),
                      _LegendItem(color: Colors.white12, label: "Free Space"),
                    ],
                  )
                ],
              ),
            ),

            const SizedBox(height: 32),
            const Text("SETTINGS",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2)),
            const SizedBox(height: 16),

            Container(
              decoration: BoxDecoration(
                  color: const Color(0xFF161B22),
                  borderRadius: BorderRadius.circular(16)),
              padding: const EdgeInsets.symmetric(vertical: 8), // Inner padding
              child: Column(
                children: [
                  SwitchListTile(
                    secondary: const Icon(Icons.wifi, color: Colors.white),
                    title: const Text("Download over Wi-Fi only",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14)),
                    subtitle: const Text("Save mobile data",
                        style: TextStyle(color: Colors.grey, fontSize: 12)),
                    value: true,
                    onChanged: (v) {},
                    activeThumbColor: Colors.blueAccent,
                  ),
                  const Divider(height: 1, color: Colors.white10),
                  SwitchListTile(
                    secondary:
                        const Icon(Icons.sd_storage, color: Colors.white),
                    title: const Text("Smart Cache",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14)),
                    subtitle: const Text("Auto-delete played cache",
                        style: TextStyle(color: Colors.grey, fontSize: 12)),
                    value: false,
                    onChanged: (v) {},
                    activeThumbColor: Colors.blueAccent,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),
            const Text("DOWNLOADED CONTENT",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2)),
            const SizedBox(height: 16),

            Container(
              decoration: BoxDecoration(
                  color: const Color(0xFF161B22),
                  borderRadius: BorderRadius.circular(16)),
              child: const Column(
                children: [
                  _ContentItem(
                      icon: Icons.library_music,
                      title: "Offline Tracks",
                      subtitle: "1,248 Files",
                      size: "12.4 GB",
                      color: Colors.cyan),
                  Divider(height: 1, color: Colors.white10),
                  _ContentItem(
                      icon: Icons.podcasts,
                      title: "Podcasts",
                      subtitle: "14 Episodes",
                      size: "450 MB",
                      color: Colors.purple),
                  Divider(height: 1, color: Colors.white10),
                  _ContentItem(
                      icon: Icons.image,
                      title: "Artwork Cache",
                      subtitle: "Metadata & Images",
                      size: "120 MB",
                      color: Colors.grey),
                ],
              ),
            ),

            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: BorderSide(color: Colors.redAccent.withOpacity(0.5)),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                ),
                onPressed: () {},
                icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                label: const Text("Clear All Downloads",
                    style: TextStyle(
                        color: Colors.redAccent, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;
  const _LegendItem({required this.color, required this.label});
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
      const SizedBox(width: 8),
      Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
    ]);
  }
}

class _ContentItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String size;
  final Color color;

  const _ContentItem(
      {required this.icon,
      required this.title,
      required this.subtitle,
      required this.size,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12)),
        child: Icon(icon, color: color, size: 24),
      ),
      title: Text(title,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
      subtitle: Text(subtitle,
          style: const TextStyle(color: Colors.grey, fontSize: 12)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(size,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14)),
          const SizedBox(width: 8),
          const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
        ],
      ),
      onTap: () {},
    );
  }
}

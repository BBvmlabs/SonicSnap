import 'package:flutter/material.dart';
import 'package:sonic_snap/features/playlist/view/playlist_details_screen.dart';

class PlaylistGridWidget extends StatefulWidget {
  const PlaylistGridWidget({super.key});

  @override
  State<PlaylistGridWidget> createState() => _PlaylistGridWidgetState();
}

class _PlaylistGridWidgetState extends State<PlaylistGridWidget> {
  final List<Map<String, dynamic>> _playlists = [
    {
      "title": "The Fat of the Land",
      "artist": "The Prodigy",
      "image": "https://picsum.photos/seed/playlist1/400/400",
      "tracks": 10,
      "year": "1997",
      "color": Colors.orange,
    },
    {
      "title": "Hurry Up, We're Dreaming",
      "artist": "M83",
      "image": "https://picsum.photos/seed/playlist2/400/400",
      "tracks": 22,
      "year": "2011",
      "color": Colors.blue,
    },
    {
      "title": "Random Access Memories",
      "artist": "Daft Punk",
      "image": "https://picsum.photos/seed/playlist3/400/400",
      "tracks": 13,
      "year": "2013",
      "color": Colors.grey,
    },
    {
      "title": "Discovery",
      "artist": "Daft Punk",
      "image": "https://picsum.photos/seed/playlist4/400/400",
      "tracks": 14,
      "year": "2001",
      "color": Colors.blueGrey,
    },
    {
      "title": "Homework",
      "artist": "Daft Punk",
      "image": "https://picsum.photos/seed/playlist5/400/400",
      "tracks": 16,
      "year": "1997",
      "color": Colors.red,
    },
    {
      "title": "Mezzanine",
      "artist": "Massive Attack",
      "image": "https://picsum.photos/seed/playlist6/400/400",
      "tracks": 11,
      "year": "1998",
      "color": Colors.green,
    },
    {
      "title": "Dummy",
      "artist": "Portishead",
      "image": "https://picsum.photos/seed/playlist7/400/400",
      "tracks": 11,
      "year": "1994",
      "color": Colors.indigo,
    },
    {
      "title": "Untrue",
      "artist": "Burial",
      "image": "https://picsum.photos/seed/playlist8/400/400",
      "tracks": 13,
      "year": "2007",
      "color": Colors.black,
    },
    {
      "title": "Music Has the Right to Children",
      "artist": "Boards of Canada",
      "image": "https://picsum.photos/seed/playlist9/400/400",
      "tracks": 18,
      "year": "1998",
      "color": Colors.teal,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isBigScreen = MediaQuery.of(context).size.width > 900;
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = 2;
        if (constraints.maxWidth > 1200) {
          crossAxisCount = 6;
        } else if (constraints.maxWidth > 900) {
          crossAxisCount = 4;
        } else if (constraints.maxWidth > 600) {
          crossAxisCount = 3;
        }

        return GridView.builder(
          padding: EdgeInsets.all(isBigScreen ? 40 : 20),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: isBigScreen ? 24 : 16,
            mainAxisSpacing: isBigScreen ? 32 : 24,
            childAspectRatio: isBigScreen ? 0.75 : 0.68,
          ),
          itemCount: _playlists.length,
          itemBuilder: (context, index) {
            final playlist = _playlists[index];
            return _PlaylistCard(playlist: playlist, isBigScreen: isBigScreen);
          },
        );
      },
    );
  }
}

class _PlaylistCard extends StatefulWidget {
  final Map<String, dynamic> playlist;
  final bool isBigScreen;

  const _PlaylistCard({required this.playlist, required this.isBigScreen});

  @override
  State<_PlaylistCard> createState() => _PlaylistCardState();
}

class _PlaylistCardState extends State<_PlaylistCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PlaylistDetailsScreen(
                title: widget.playlist['title'],
                artist: widget.playlist['artist'],
                image: widget.playlist['image'],
                isBigScreen: widget.isBigScreen,
              ),
            ),
          );
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: _isHovered
                ? Colors.white.withValues(alpha: 0.05)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.4),
                            blurRadius: 15,
                            offset: const Offset(0, 8),
                          ),
                        ],
                        image: DecorationImage(
                          image: widget.playlist['image'].startsWith('http')
                              ? NetworkImage(widget.playlist['image'])
                                  as ImageProvider
                              : AssetImage(widget.playlist['image']),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    if (_isHovered)
                      Positioned(
                        right: 8,
                        bottom: 8,
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.cyanAccent.shade400,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.cyanAccent.withValues(alpha: 0.4),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const Icon(Icons.play_arrow,
                              color: Colors.black, size: 28),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                widget.playlist['title'].toUpperCase(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "${widget.playlist['artist']} • ${widget.playlist['year']}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                "${widget.playlist['tracks']} TRACKS",
                style: TextStyle(
                  color: Colors.cyanAccent.shade400.withValues(alpha: 0.7),
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

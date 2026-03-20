import 'package:flutter/material.dart';
import 'package:sonic_snap/features/album/view/album_details_screen.dart';

class AlbumGridWidget extends StatefulWidget {
  const AlbumGridWidget({super.key});

  @override
  State<AlbumGridWidget> createState() => _AlbumGridWidgetState();
}

class _AlbumGridWidgetState extends State<AlbumGridWidget> {
  final List<Map<String, dynamic>> _albums = [
    {
      "title": "The Fat of the Land",
      "artist": "The Prodigy",
      "image": "https://picsum.photos/seed/album1/400/400",
      "tracks": 10,
      "year": "1997",
      "color": Colors.orange,
    },
    {
      "title": "Hurry Up, We're Dreaming",
      "artist": "M83",
      "image": "https://picsum.photos/seed/album2/400/400",
      "tracks": 22,
      "year": "2011",
      "color": Colors.blue,
    },
    {
      "title": "Random Access Memories",
      "artist": "Daft Punk",
      "image": "https://picsum.photos/seed/album3/400/400",
      "tracks": 13,
      "year": "2013",
      "color": Colors.grey,
    },
    {
      "title": "Discovery",
      "artist": "Daft Punk",
      "image": "https://picsum.photos/seed/album4/400/400",
      "tracks": 14,
      "year": "2001",
      "color": Colors.blueGrey,
    },
    {
      "title": "Homework",
      "artist": "Daft Punk",
      "image": "https://picsum.photos/seed/album5/400/400",
      "tracks": 16,
      "year": "1997",
      "color": Colors.red,
    },
    {
      "title": "Mezzanine",
      "artist": "Massive Attack",
      "image": "https://picsum.photos/seed/album6/400/400",
      "tracks": 11,
      "year": "1998",
      "color": Colors.green,
    },
    {
      "title": "Dummy",
      "artist": "Portishead",
      "image": "https://picsum.photos/seed/album7/400/400",
      "tracks": 11,
      "year": "1994",
      "color": Colors.indigo,
    },
    {
      "title": "Untrue",
      "artist": "Burial",
      "image": "https://picsum.photos/seed/album8/400/400",
      "tracks": 13,
      "year": "2007",
      "color": Colors.black,
    },
    {
      "title": "Music Has the Right to Children",
      "artist": "Boards of Canada",
      "image": "https://picsum.photos/seed/album9/400/400",
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
          padding: const EdgeInsets.all(40),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 24,
            mainAxisSpacing: 32,
            childAspectRatio: 0.75,
          ),
          itemCount: _albums.length,
          itemBuilder: (context, index) {
            final album = _albums[index];
            return _AlbumCard(album: album, isBigScreen: isBigScreen);
          },
        );
      },
    );
  }
}

class _AlbumCard extends StatefulWidget {
  final Map<String, dynamic> album;
  final bool isBigScreen;

  const _AlbumCard({required this.album, required this.isBigScreen});

  @override
  State<_AlbumCard> createState() => _AlbumCardState();
}

class _AlbumCardState extends State<_AlbumCard> {
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
              builder: (context) => AlbumDetailsScreen(
                title: widget.album['title'],
                artist: widget.album['artist'],
                image: widget.album['image'],
                isBigScreen: widget.isBigScreen,
              ),
            ),
          );
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: _isHovered
                ? Colors.white.withOpacity(0.05)
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
                            color: Colors.black.withOpacity(0.4),
                            blurRadius: 15,
                            offset: const Offset(0, 8),
                          ),
                        ],
                        image: DecorationImage(
                          image: widget.album['image'].startsWith('http')
                              ? NetworkImage(widget.album['image'])
                                  as ImageProvider
                              : AssetImage(widget.album['image']),
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
                                color: Colors.cyanAccent.withOpacity(0.4),
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
                widget.album['title'].toUpperCase(),
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
                "${widget.album['artist']} • ${widget.album['year']}",
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
                "${widget.album['tracks']} TRACKS",
                style: TextStyle(
                  color: Colors.cyanAccent.shade400.withOpacity(0.7),
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

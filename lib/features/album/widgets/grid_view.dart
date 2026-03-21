import 'package:flutter/material.dart';
import 'package:sonic_snap/data/dummy_data.dart';
import 'package:sonic_snap/features/album/view/album_details_screen.dart';

class AlbumGridWidget extends StatefulWidget {
  const AlbumGridWidget({super.key});

  @override
  State<AlbumGridWidget> createState() => _AlbumGridWidgetState();
}

class _AlbumGridWidgetState extends State<AlbumGridWidget> {
  List<Map<String, dynamic>> get _albums {
    final Map<String, Map<String, dynamic>> albumMap = {};
    for (var song in dummySongs) {
      final parts = song['artist'].split(' • ');
      final artistName = parts[0];
      final albumTitle = parts.length > 1 ? parts[1] : 'Unknown Album';
      
      if (!albumMap.containsKey(albumTitle)) {
        albumMap[albumTitle] = {
          'title': albumTitle,
          'artist': artistName,
          'image': song['image'],
          'tracks': 1,
          'year': '2023',
          'color': song['color'],
        };
      } else {
        albumMap[albumTitle]!['tracks'] = (albumMap[albumTitle]!['tracks'] as int) + 1;
      }
    }
    return albumMap.values.toList();
  }

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

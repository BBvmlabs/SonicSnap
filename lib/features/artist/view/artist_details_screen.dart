import 'package:flutter/material.dart';
import 'package:sonic_snap/core/app_theme.dart';
import 'package:sonic_snap/features/music/widgets/bottom_sheets.dart';

class ArtistDetailsScreen extends StatefulWidget {
  final List<Map<String, dynamic>> songs = [
    {
      'title': 'Breathe',
      'artist': 'The Prodigy',
      'duration': '5:33',
      'image': 'assets/images/artist_1.png'
    },
    {
      'title': 'Firestarter',
      'artist': 'The Prodigy',
      'duration': '4:41',
      'image': 'assets/images/artist_2.png'
    },
    {
      'title': 'Smack My Bitch Up',
      'artist': 'The Prodigy',
      'duration': '5:23',
      'image': 'assets/images/artist_3.png'
    },
    {
      'title': 'Omen',
      'artist': 'The Prodigy',
      'duration': '3:36',
      'image': 'assets/images/artist_4.png'
    },
    {
      'title': 'Voodoo People',
      'artist': 'The Prodigy',
      'duration': '5:07',
      'image': 'assets/images/artist_5.png'
    },
  ];
  final String title;
  final String artist;
  final String image;
  final bool isBigScreen;

  ArtistDetailsScreen({
    super.key,
    required this.title,
    required this.artist,
    required this.image,
    this.isBigScreen = false,
  });

  @override
  State<ArtistDetailsScreen> createState() => _ArtistDetailsScreenState();
}

class _ArtistDetailsScreenState extends State<ArtistDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppTheme.darkTheme,
      child: Scaffold(
        backgroundColor: AppTheme.darkBg,
        body: widget.isBigScreen
            ? buildNewDesktopScreen(context)
            : buildNewMobileScreen(context),
      ),
    );
  }

  Widget buildNewMobileScreen(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 400,
          pinned: true,
          backgroundColor: AppTheme.darkBg,
          elevation: 0,
          leading: IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              child:
                  const Icon(Icons.arrow_back, color: Colors.white, size: 20),
            ),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.favorite_border,
                    color: Colors.white, size: 20),
              ),
              onPressed: () {},
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                child:
                    const Icon(Icons.more_vert, color: Colors.white, size: 20),
              ),
              onPressed: () {},
            ),
            const SizedBox(width: 16),
          ],
          flexibleSpace: FlexibleSpaceBar(
            background: Stack(
              fit: StackFit.expand,
              children: [
                widget.image.startsWith('http')
                    ? Image.network(widget.image, fit: BoxFit.cover)
                    : Image.asset(widget.image, fit: BoxFit.cover),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.2),
                        AppTheme.darkBg.withOpacity(0.8),
                        AppTheme.darkBg,
                      ],
                      stops: const [0.0, 0.7, 1.0],
                    ),
                  ),
                ),
                Positioned(
                  left: 24,
                  bottom: 40,
                  right: 24,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'ALBUM',
                        style: TextStyle(
                          color: AppTheme.primaryCyan,
                          fontSize: 12,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 2.0,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.title.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -1,
                          height: 1.1,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.artist,
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text("ALBUM", style: _tagStyle),
                          const SizedBox(width: 8),
                          Text("•", style: TextStyle(color: Colors.grey[600])),
                          const SizedBox(width: 8),
                          Text("1997", style: _tagStyle),
                          const SizedBox(width: 8),
                          Text("•", style: TextStyle(color: Colors.grey[600])),
                          const SizedBox(width: 8),
                          Text("HI-RES", style: _tagStyle),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.play_arrow_rounded, size: 28),
                    label: const Text("PLAY"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryCyan,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.shuffle, color: Colors.white),
                    onPressed: () {},
                    padding: const EdgeInsets.all(16),
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final song = widget.songs[index % widget.songs.length];
              return _buildMobileTrackItem(context, index + 1, song);
            },
            childCount: 15,
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("© 1997 XL Recordings Ltd.",
                    style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                        fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text("Total Duration: 56:24",
                    style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                        fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 120)),
      ],
    );
  }

  Widget buildNewDesktopScreen(BuildContext context) {
    return Row(
      children: [
        // Left Column: Artist Art and Info (Fixed-ish)
        Expanded(
          flex: 4,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppTheme.primaryCyan.withOpacity(0.1),
                  AppTheme.darkBg,
                ],
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 50,
                  left: 20,
                  child: IconButton(
                    icon: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(60),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Hero(
                          tag: 'artist-art-${widget.title}',
                          child: Container(
                            height: 300,
                            width: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.6),
                                  blurRadius: 60,
                                  offset: const Offset(0, 30),
                                ),
                                BoxShadow(
                                  color: AppTheme.primaryCyan.withOpacity(0.1),
                                  blurRadius: 100,
                                  spreadRadius: -20,
                                ),
                              ],
                              image: DecorationImage(
                                image: widget.image.startsWith('http')
                                    ? NetworkImage(widget.image)
                                        as ImageProvider
                                    : AssetImage(widget.image),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 46),
                        Text(
                          widget.title.toUpperCase(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 48,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -1,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          widget.artist,
                          style: const TextStyle(
                            color: AppTheme.primaryCyan,
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 32),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildDesktopActionButton(
                                Icons.play_arrow_rounded, "PLAY", true),
                            const SizedBox(width: 16),
                            _buildDesktopActionButton(
                                Icons.shuffle, "SHUFFLE", false),
                            const SizedBox(width: 16),
                            _buildDesktopCircleButton(Icons.favorite_border),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // Right Column: Track List (Scrollable)
        Expanded(
          flex: 6,
          child: Container(
            color: AppTheme.darkBg,
            child: CustomScrollView(
              slivers: [
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(40, 60, 40, 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "ABOUT THIS ALBUM",
                          style: TextStyle(
                            color: Colors.white38,
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 2.0,
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          "1997 • 12 Tracks • 56:24 • Hi-Res Audio (24-bit/96kHz)",
                          style: TextStyle(
                            color: Colors.white60,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  sliver: SliverToBoxAdapter(
                    child: _buildTableHeader(),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final song = widget.songs[index % widget.songs.length];
                        return _buildDesktopTrackItem(context, index + 1, song);
                      },
                      childCount: 12,
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 100)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopActionButton(
      IconData icon, String label, bool isPrimary) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      decoration: BoxDecoration(
        color:
            isPrimary ? AppTheme.primaryCyan : Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        boxShadow: isPrimary
            ? [
                BoxShadow(
                  color: AppTheme.primaryCyan.withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                )
              ]
            : [],
      ),
      child: Row(
        children: [
          Icon(icon, color: isPrimary ? Colors.black : Colors.white, size: 24),
          const SizedBox(width: 12),
          Text(
            label,
            style: TextStyle(
              color: isPrimary ? Colors.black : Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 16,
              letterSpacing: 1.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopCircleButton(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: Colors.white, size: 24),
    );
  }

  static final _tagStyle = TextStyle(
      fontSize: 12,
      color: Colors.grey[500],
      fontWeight: FontWeight.w800,
      letterSpacing: 1.2);

  Widget _buildMobileTrackItem(
      BuildContext context, int index, Map<String, dynamic> song) {
    final isPlaying = index == 3;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
      leading: SizedBox(
        width: 32,
        child: isPlaying
            ? const Icon(Icons.bar_chart, color: AppTheme.primaryCyan)
            : Text("$index",
                style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 14,
                    fontWeight: FontWeight.bold)),
      ),
      title: Text(song['title'],
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              color: isPlaying ? AppTheme.primaryCyan : Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 15)),
      subtitle: Text(widget.artist,
          style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12,
              fontWeight: FontWeight.w600)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (index % 4 == 0)
            const Padding(
              padding: EdgeInsets.only(right: 12),
              child: Icon(Icons.explicit, color: Colors.white24, size: 16),
            ),
          Text(song['duration'],
              style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 13,
                  fontWeight: FontWeight.w600)),
          const SizedBox(width: 8),
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.grey[800], size: 20),
            onPressed: () {
              showSongOptionsSheet(context, {
                'title': song['title'],
                'artist': widget.artist,
                'image': widget.image,
              });
            },
          ),
        ],
      ),
      onTap: () {},
    );
  }

  Widget _buildTableHeader() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(width: 40, child: Text('#', style: _headerStyle)),
              Expanded(flex: 4, child: Text('TITLE', style: _headerStyle)),
              Expanded(flex: 3, child: Text('ALBUM', style: _headerStyle)),
              SizedBox(
                  width: 100,
                  child: Text('DURATION',
                      style: _headerStyle, textAlign: TextAlign.right)),
              SizedBox(width: 60),
            ],
          ),
          SizedBox(height: 12),
          Divider(color: Colors.white10),
        ],
      ),
    );
  }

  static const _headerStyle = TextStyle(
    color: Colors.white38,
    fontSize: 11,
    fontWeight: FontWeight.w900,
    letterSpacing: 2.0,
  );

  Widget _buildDesktopTrackItem(
      BuildContext context, int index, Map<String, dynamic> song) {
    return Container(
      height: 72,
      margin: const EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(12),
          hoverColor: Colors.white.withOpacity(0.03),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                SizedBox(
                  width: 40,
                  child: Text(
                    index.toString().padLeft(2, '0'),
                    style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 13,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Row(
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
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
                            song['widget.title'].toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.artist,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 13,
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
                    widget.title.toUpperCase(),
                    style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 13,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: Text(
                    song['duration'],
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 13,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  width: 60,
                  child: IconButton(
                    icon: const Icon(Icons.more_horiz, color: Colors.white24),
                    onPressed: () {
                      showSongOptionsSheet(context, {
                        'title': song['title'],
                        'artist': widget.artist,
                        'image': widget.image,
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

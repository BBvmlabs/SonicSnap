import 'dart:math';
import 'package:flutter/material.dart';
import 'package:sonic_snap/features/music/widgets/album_art_widget.dart';
import 'package:sonic_snap/features/music/widgets/song_info_widget.dart';
import 'package:sonic_snap/features/music/widgets/audio_visualizer_widget.dart';
import 'package:sonic_snap/features/music/widgets/playback_controls_widget.dart';
import 'package:sonic_snap/features/music/widgets/action_buttons_widget.dart';
import 'package:sonic_snap/features/music/widgets/audio_quality_badge.dart';
import 'package:sonic_snap/features/music/widgets/mini_player_widget.dart';
import 'package:sonic_snap/widgets/build_tag.dart';

class PlayNowScreen extends StatefulWidget {
  final int selectedSongIndex;
  final List<Map<String, dynamic>> songs;
  final bool isExpanded;
  final String title;
  final String image;
  final Color color;
  final String description;
  final bool isPlaying;
  final VoidCallback onPlayPause;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final VoidCallback onTap;
  final bool isBigScreen;

  const PlayNowScreen({
    required this.selectedSongIndex,
    required this.songs,
    required this.isExpanded,
    super.key,
    required this.title,
    required this.image,
    required this.description,
    required this.onTap,
    required this.onPlayPause,
    required this.onPrevious,
    required this.onNext,
    required this.color,
    required this.isPlaying,
    required this.isBigScreen,
  });

  @override
  State<PlayNowScreen> createState() => _PlayNowScreenState();
}

class _PlayNowScreenState extends State<PlayNowScreen>
    with TickerProviderStateMixin {
  late bool isExpanded;
  double currentPosition = 55; // in seconds
  double totalDuration = 258; // in seconds (4:18)
  late AnimationController _animationController;
  late AnimationController _visualizerController;

  @override
  void initState() {
    super.initState();
    isExpanded = widget.isExpanded;
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    if (isExpanded) {
      _animationController.forward();
    }
    _visualizerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    if (widget.isPlaying) {
      _visualizerController.repeat();
    }
  }

  @override
  void didUpdateWidget(PlayNowScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isExpanded != oldWidget.isExpanded) {
      setState(() {
        isExpanded = widget.isExpanded;
        if (isExpanded) {
          _animationController.forward();
        } else {
          _animationController.reverse();
        }
      });
    }
    if (widget.isPlaying != oldWidget.isPlaying) {
      if (widget.isPlaying) {
        _visualizerController.repeat();
      } else {
        _visualizerController.stop();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _visualizerController.dispose();
    super.dispose();
  }

  void _toggleView() {
    widget.onTap();
  }

  void _togglePlayPause() {
    widget.onPlayPause();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !isExpanded,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        _toggleView();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        height: isExpanded ? MediaQuery.of(context).size.height : 80,
        child: Scaffold(
          backgroundColor: Colors.transparent, // Handle background in container
          body: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: isExpanded ? _buildFullPlayer() : _buildMiniPlayer(),
          ),
        ),
      ),
    );
  }

  Widget _buildMiniPlayer() {
    return widget.isBigScreen
        ? _buildWideMiniLayout()
        : Container(
            color: const Color.fromRGBO(
                0, 0, 0, 0), // Or a solid background if needed
            child: MiniPlayerWidget(
              title: widget.title,
              image: widget.image,
              description: widget.description,
              color: widget.color,
              isPlaying: widget.isPlaying,
              onTap: widget.onTap,
              onPlayPause: _togglePlayPause,
              onPrevious: widget.onPrevious,
              onNext: widget.onNext,
            ),
          );
  }

  Widget _buildFullPlayer() {
    return GestureDetector(
      onVerticalDragUpdate: (details) {
        // Simple swipe down detection
        if (details.delta.dy > 10) {
          _toggleView();
        }
      },
      child: OverflowBox(
        minHeight: MediaQuery.of(context).size.height,
        maxHeight: MediaQuery.of(context).size.height,
        alignment: Alignment.topCenter,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                widget.color,
                Colors.black,
                Colors.black,
              ],
              stops: const [0.0, 0.5, 1.0],
            ),
          ),
          child: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isWideScreen = constraints.maxWidth > 900;
                if (isWideScreen) {
                  return Column(
                    children: [
                      Expanded(child: _buildDesktopLayout()),
                      _buildWidePlayerBar(isMini: false, showQueue: false),
                    ],
                  );
                }
                return _buildMobileLayout();
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return SizedBox(
      height: kToolbarHeight,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: _toggleView,
              icon: const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Colors.white,
                size: 32,
              ),
            ),
            const Text(
              'Now Playing',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            IconButton(
              onPressed: () {
                // Cast or share functionality
              },
              icon: Icon(
                Icons.graphic_eq,
                color: Colors.white.withValues(alpha: 0.7),
                size: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        _buildAppBar(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Album art - Flexible to take available space
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: AlbumArtWidget(
                      image: widget.image,
                      color: widget.color,
                      isPlaying: widget.isPlaying,
                    ),
                  ),
                ),

                // Song info and action buttons
                const SizedBox(height: 20),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SongInfoWidget(
                      title: widget.title,
                      description: widget.description,
                    ),
                    const SizedBox(height: 20),
                    ActionButtonsWidget(
                      color: widget.color,
                    ),
                  ],
                ),

                const Spacer(flex: 1),

                // Audio visualizer
                AudioVisualizerWidget(
                  currentPosition: currentPosition,
                  totalDuration: totalDuration,
                  color: widget.color,
                  isPlaying: widget.isPlaying,
                ),

                const SizedBox(height: 10),

                // Playback controls
                PlaybackControlsWidget(
                  isPlaying: widget.isPlaying,
                  onPlayPause: _togglePlayPause,
                  onPrevious: widget.onPrevious,
                  onNext: widget.onNext,
                  color: widget.color,
                ),

                const SizedBox(height: 10),

                // Audio quality badge
                AudioQualityBadge(
                  quality: 'FLAC 24-bit / 96 kHz',
                  color: widget.color,
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWideMiniLayout() {
    return GestureDetector(
      onTap: widget.onTap,
      behavior: HitTestBehavior.opaque,
      child: _buildWidePlayerBar(isMini: true),
    );
  }

  Widget _buildDesktopLayout() {
    final nowPlaying = widget.songs[widget.selectedSongIndex];
    return Row(
      children: [
        // Left Side: Now Playing Info
        Expanded(
          flex: 6,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tag Section
                Row(
                  children: [
                    buildTag('NOW PLAYING',
                        color: Colors.white.withValues(alpha: 0.5),
                        textColor: Colors.black),
                    const SizedBox(width: 12),
                    buildTag('HI-RES 192KHZ'),
                    const SizedBox(width: 12),
                    buildTag('STUDIO MASTER'),
                  ],
                ),
                const SizedBox(height: 48),

                // Artwork & Large Title
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Large Artwork
                    Container(
                      width: 420,
                      height: 420,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          image: AssetImage(nowPlaying['image']),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 64),

                    // Title and Artist Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          Text(
                            nowPlaying['title'].toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 72,
                              fontWeight: FontWeight.w900,
                              letterSpacing: -2,
                              height: 1.1,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            nowPlaying['description']?.toUpperCase() ??
                                'ARCHITECTS OF VOID',
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 28,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 4.0,
                            ),
                          ),
                          const SizedBox(height: 64),
                          // Specific visualizer for this section
                          _buildBarVisualizer(),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        // Right Side: Play Queue List
        Container(
          width: 480,
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.2),
            border: const Border(left: BorderSide(color: Colors.white10)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Queue Header
              Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Play Queue',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.cleaning_services_rounded,
                                  color: Colors.white54, size: 20),
                              tooltip: 'Clear Queue',
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.playlist_add_rounded,
                                  color: widget.color, size: 24),
                              tooltip: 'Save Playlist',
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'ACTIVE SESSION: SEQUENCE 04',
                      style: TextStyle(
                        color: widget.color,
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 2.0,
                      ),
                    ),
                  ],
                ),
              ),

              // Up Next Label
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  'UP NEXT',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 3.0,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Queue List Items
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: widget.songs.length - 1,
                  itemBuilder: (context, index) {
                    // Skip currently playing song for the "Up Next" list
                    final songIndex = (widget.selectedSongIndex + index + 1) %
                        widget.songs.length;
                    final song = widget.songs[songIndex];
                    return _buildQueueItem(song, index + 1);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQueueItem(Map<String, dynamic> song, int displayIndex) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: AssetImage(song['image']),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  song['title'].toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  song['description']?.toUpperCase() ?? 'THE PRODIGY',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Text(
            song['duration'] ?? '04:15',
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 12),
          Icon(Icons.drag_indicator_rounded, color: Colors.grey[800], size: 18),
        ],
      ),
    );
  }

  Widget _buildWidePlayerBar({required bool isMini, bool showQueue = true}) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: const Color(0xFF0D1117),
        border: Border(
            top: BorderSide(
                color: Colors.white.withValues(alpha: 0.05), width: 1)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Row(
        children: [
          // Left: Info & Art
          Expanded(
            flex: isMini ? 3 : 2,
            child: Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    image: DecorationImage(
                      image: AssetImage(widget.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.0,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        widget.description.toUpperCase(),
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (isMini) ...[
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            _buildTag('24-BIT / 96KHZ', color: widget.color),
                            const SizedBox(width: 4),
                            _buildTag('HI-RES'),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Center: Controls (if Mini) and Progress
          Expanded(
            flex: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        icon: const Icon(Icons.shuffle,
                            size: 18, color: Colors.white54),
                        onPressed: () {}),
                    IconButton(
                        icon: const Icon(Icons.skip_previous,
                            color: Colors.white),
                        onPressed: widget.onPrevious),
                    const SizedBox(width: 8),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: widget.color, width: 2),
                      ),
                      child: IconButton(
                        icon: Icon(
                            widget.isPlaying ? Icons.pause : Icons.play_arrow,
                            color: widget.color),
                        onPressed: widget.onPlayPause,
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                        icon: const Icon(Icons.skip_next, color: Colors.white),
                        onPressed: widget.onNext),
                    IconButton(
                        icon: const Icon(Icons.repeat,
                            size: 18, color: Colors.white54),
                        onPressed: () {}),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('01:42',
                        style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 10,
                            fontWeight: FontWeight.bold)),
                    if (!isMini) const Spacer(),
                    if (isMini)
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: _buildProgressBar(),
                        ),
                      ),
                    Text('04:05',
                        style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 10,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
                if (!isMini) ...[
                  const SizedBox(height: 8),
                  _buildProgressBar(),
                ],
              ],
            ),
          ),

          // Right: Volume & Tools
          Expanded(
            flex: isMini ? 3 : 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.volume_up, color: Colors.grey[600], size: 20),
                const SizedBox(width: 12),
                SizedBox(
                  width: 80,
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 2,
                      thumbShape:
                          const RoundSliderThumbShape(enabledThumbRadius: 4),
                      activeTrackColor: Colors.white.withValues(alpha: 0.6),
                      inactiveTrackColor: Colors.white.withValues(alpha: 0.1),
                    ),
                    child: Slider(value: 0.7, onChanged: (v) {}),
                  ),
                ),
                const SizedBox(width: 24),
                _buildToolItem(Icons.bar_chart, 'SPECTRUM', isMini),
                if (showQueue) ...[
                  const SizedBox(width: 24),
                  _buildToolItem(Icons.playlist_play, 'QUEUE', isMini),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        trackHeight: 2,
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 0),
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 0),
        activeTrackColor: widget.color,
        inactiveTrackColor: Colors.white.withValues(alpha: 0.1),
      ),
      child: Slider(value: 0.4, onChanged: (v) {}),
    );
  }

  Widget _buildToolItem(IconData icon, String label, bool isMini) {
    bool isCyan = icon == Icons.bar_chart;
    final color = isCyan ? widget.color : Colors.grey[600];
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color, size: 20),
        if (!isMini) ...[
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 8,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildTag(String text, {Color? color}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        color: color ?? Colors.white10,
        borderRadius: BorderRadius.circular(2),
        border: Border.all(color: Colors.white24),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 8,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildBarVisualizer() {
    return AnimatedBuilder(
      animation: _visualizerController,
      builder: (context, child) {
        return SizedBox(
          height: 80,
          width: 600,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: List.generate(40, (index) {
              // Create dynamic height based on animation and index
              final t = _visualizerController.value;
              final sinValue = (sin((t * 2 * pi) + (index * 0.5)) + 1) / 2;
              final variation = (index % 3 + 1) * 20.0 * sinValue;
              final baseHeight = (index % 5 + 1) * 8.0;
              final height = widget.isPlaying
                  ? (baseHeight + variation).clamp(10.0, 70.0)
                  : baseHeight;

              return Container(
                width: 8,
                height: height,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: index == 15 || index == 30 || index == 5
                      ? widget.color
                      : Theme.of(context)
                          .colorScheme
                          .primary
                          .withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(2),
                ),
              );
            }),
          ),
        );
      },
    );
  }
}

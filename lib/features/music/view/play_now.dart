import 'package:flutter/material.dart';
import 'package:sonic_snap/features/music/widgets/album_art_widget.dart';
import 'package:sonic_snap/features/music/widgets/song_info_widget.dart';
import 'package:sonic_snap/features/music/widgets/audio_visualizer_widget.dart';
import 'package:sonic_snap/features/music/widgets/playback_controls_widget.dart';
import 'package:sonic_snap/features/music/widgets/action_buttons_widget.dart';
import 'package:sonic_snap/features/music/widgets/audio_quality_badge.dart';
import 'package:sonic_snap/features/music/widgets/mini_player_widget.dart';

class PlayNowScreen extends StatefulWidget {
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
    with SingleTickerProviderStateMixin {
  late bool isExpanded;
  double currentPosition = 55; // in seconds
  double totalDuration = 258; // in seconds (4:18)
  late AnimationController _animationController;

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
  }

  @override
  void dispose() {
    _animationController.dispose();
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
              stops: const [0.0, 0.3, 1.0],
            ),
          ),
          child: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isWideScreen = constraints.maxWidth > 900;
                return isWideScreen ? _buildWideLayout() : _buildNarrowLayout();
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

  Widget _buildNarrowLayout() {
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

  Widget _buildWideLayout() {
    return Container(
      color: const Color(0xFF080C11).withValues(alpha: 0.95),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

          // Main Center Content
          Expanded(
            child: Column(
              children: [
                _buildPlayerHeader(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 32),
                        // Album Art with Badge
                        _buildMainNowPlaying(),

                        const SizedBox(height: 48),

                        // Artist & Title
                        Text(
                          widget.title.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 52,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -1.0,
                          ),
                        ),
                        Text(
                          widget.description.toUpperCase(),
                          style: TextStyle(
                            color: Colors.cyanAccent.shade400,
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 2.0,
                          ),
                        ),

                        const SizedBox(height: 32),

                        // Stats Row (Format, Bitrate, Sample Rate)
                        _buildTechnicalStats(),

                        const SizedBox(height: 48),

                        // Visualizer
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 100),
                          child: AudioVisualizerWidget(
                            currentPosition: currentPosition,
                            totalDuration: totalDuration,
                            color: Colors.cyanAccent.shade400,
                            isPlaying: widget.isPlaying,
                          ),
                        ),

                        const SizedBox(height: 48),

                        // Controls
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 100),
                          child: PlaybackControlsWidget(
                            isPlaying: widget.isPlaying,
                            onPlayPause: _togglePlayPause,
                            onPrevious: widget.onPrevious,
                            onNext: widget.onNext,
                            color: Colors.cyanAccent.shade400,
                          ),
                        ),

                        const SizedBox(height: 48),
                      ],
                    ),
                  ),
                ),
                // Unified Bottom Bar
                _buildWidePlayerBar(isMini: false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayerHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(48, 32, 48, 0),
      child: Row(
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Colors.cyanAccent,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'SYSTEM ONLINE',
                style: TextStyle(
                  color: Colors.cyanAccent.shade400,
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2.0,
                ),
              ),
            ],
          ),
          const Spacer(),
          Container(
            width: 300,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(4),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'SEARCH FREQUENCY...',
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                Icon(Icons.search, size: 16, color: Colors.grey[800]),
              ],
            ),
          ),
          const SizedBox(width: 32),
          Icon(Icons.notifications_none,
              color: Colors.white.withValues(alpha: 0.7), size: 22),
          const SizedBox(width: 24),
          Icon(Icons.bar_chart,
              color: Colors.white.withValues(alpha: 0.7), size: 22),
          const SizedBox(width: 24),
          const CircleAvatar(
            radius: 16,
            backgroundColor: Color(0xFF161B22),
            child: Icon(Icons.person, color: Colors.white70, size: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildMainNowPlaying() {
    return Center(
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Container(
            width: 450,
            height: 450,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.cyanAccent.shade400.withValues(alpha: 0.1),
                  blurRadius: 100,
                  spreadRadius: -20,
                ),
              ],
              image: DecorationImage(
                image: AssetImage(widget.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF0D1117).withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(2),
                border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'HI-RES',
                    style: TextStyle(
                      color: Colors.cyanAccent.shade400,
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.0,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    '24-BIT',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTechnicalStats() {
    return Container(
      width: 450,
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.02),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStatItem('FORMAT', 'FLAC'),
          _buildStatItem('BITRATE', '1411 KBPS'),
          _buildStatItem('SAMPLE RATE', '44.1 KHZ'),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[700],
            fontSize: 9,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.0,
          ),
        ),
      ],
    );
  }

  Widget _buildWidePlayerBar({required bool isMini}) {
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
                            _buildTag('24-BIT / 96KHZ',
                                color: Colors.purple.shade900),
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
                if (isMini) ...[
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
                          border:
                              Border.all(color: Colors.cyanAccent, width: 2),
                        ),
                        child: IconButton(
                          icon: Icon(
                              widget.isPlaying ? Icons.pause : Icons.play_arrow,
                              color: Colors.cyanAccent),
                          onPressed: widget.onPlayPause,
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                          icon:
                              const Icon(Icons.skip_next, color: Colors.white),
                          onPressed: widget.onNext),
                      IconButton(
                          icon: const Icon(Icons.repeat,
                              size: 18, color: Colors.white54),
                          onPressed: () {}),
                    ],
                  ),
                  const SizedBox(height: 4),
                ],
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
                const SizedBox(width: 24),
                _buildToolItem(Icons.playlist_play, 'QUEUE', isMini),
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
        activeTrackColor: Colors.cyanAccent.shade400,
        inactiveTrackColor: Colors.white.withValues(alpha: 0.1),
      ),
      child: Slider(value: 0.4, onChanged: (v) {}),
    );
  }

  Widget _buildToolItem(IconData icon, String label, bool isMini) {
    bool isCyan = icon == Icons.bar_chart;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon,
            color: isCyan ? Colors.cyanAccent : Colors.grey[600], size: 20),
        if (!isMini) ...[
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isCyan ? Colors.cyanAccent : Colors.grey[600],
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
}

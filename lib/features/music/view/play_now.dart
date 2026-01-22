import 'package:flutter/material.dart';
import 'package:sonic_snap/features/music/widgets/album_art_widget.dart';
import 'package:sonic_snap/features/music/widgets/song_info_widget.dart';
import 'package:sonic_snap/features/music/widgets/audio_visualizer_widget.dart';
import 'package:sonic_snap/features/music/widgets/playback_controls_widget.dart';
import 'package:sonic_snap/features/music/widgets/action_buttons_widget.dart';
import 'package:sonic_snap/features/music/widgets/audio_quality_badge.dart';
import 'package:sonic_snap/features/music/widgets/mini_player_widget.dart';

class PlayNowScreen extends StatefulWidget {
  final bool isExpanded;
  final String title;
  final String image;
  final Color color;
  final String description;
  final Function() onTap;
  final Function() onPrevious;
  final Function() onNext;
  final Function() onPressed;

  const PlayNowScreen({
    required this.isExpanded,
    super.key,
    required this.title,
    required this.image,
    required this.description,
    required this.onTap,
    required this.onPrevious,
    required this.onNext,
    required this.onPressed,
    required this.color,
  });

  @override
  State<PlayNowScreen> createState() => _PlayNowScreenState();
}

class _PlayNowScreenState extends State<PlayNowScreen>
    with SingleTickerProviderStateMixin {
  bool isPlaying = true;
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
    setState(() {
      isExpanded = !isExpanded;
      if (isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  void _togglePlayPause() {
    setState(() {
      isPlaying = !isPlaying;
    });
    widget.onPressed();
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
    return Container(
      color: Colors.transparent, // Or a solid background if needed
      child: MiniPlayerWidget(
        title: widget.title,
        image: widget.image,
        description: widget.description,
        color: widget.color,
        isPlaying: isPlaying,
        onTap: _toggleView,
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
                widget.color.withOpacity(0.3),
                Colors.black,
                Colors.black,
              ],
              stops: const [0.0, 0.3, 1.0],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                // App bar with back button and options
                _buildAppBar(),

                // Main content
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final isWideScreen = constraints.maxWidth > 600;
                      return isWideScreen
                          ? _buildWideLayout()
                          : _buildNarrowLayout();
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
                Icons.cast_rounded,
                color: Colors.white.withOpacity(0.7),
                size: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNarrowLayout() {
    // Using Column with Expanded/Flexible to fit screen without scrolling
    return Padding(
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
                isPlaying: isPlaying,
              ),
            ),
          ),

          // Song info and action buttons
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SongInfoWidget(
                title: widget.title,
                description: widget.description,
              ),
              const SizedBox(height: 10),
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
            isPlaying: isPlaying,
          ),

          const SizedBox(height: 10),

          // Playback controls
          PlaybackControlsWidget(
            isPlaying: isPlaying,
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
    );
  }

  Widget _buildWideLayout() {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Row(
        children: [
          // Left side - Album art
          Expanded(
            flex: 1,
            child: AlbumArtWidget(
              image: widget.image,
              color: widget.color,
              isPlaying: isPlaying,
            ),
          ),

          const SizedBox(width: 60),

          // Right side - Controls
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SongInfoWidget(
                  title: widget.title,
                  description: widget.description,
                ),
                const SizedBox(height: 20),
                ActionButtonsWidget(
                  color: widget.color,
                ),
                const Spacer(),
                AudioVisualizerWidget(
                  currentPosition: currentPosition,
                  totalDuration: totalDuration,
                  color: widget.color,
                  isPlaying: isPlaying,
                ),
                const SizedBox(height: 20),
                PlaybackControlsWidget(
                  isPlaying: isPlaying,
                  onPlayPause: _togglePlayPause,
                  onPrevious: widget.onPrevious,
                  onNext: widget.onNext,
                  color: widget.color,
                ),
                const SizedBox(height: 20),
                AudioQualityBadge(
                  quality: 'FLAC 24-bit / 96 kHz',
                  color: widget.color,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

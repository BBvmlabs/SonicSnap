# Music Player Widgets - Usage Guide

## Quick Start

All widgets are now separated in the `lib/features/music/widgets/` folder for better organization and reusability.

### Import All Widgets

```dart
import 'package:sonic_snap/features/music/widgets/widgets.dart';
```

Or import individually:

```dart
import 'package:sonic_snap/features/music/widgets/album_art_widget.dart';
import 'package:sonic_snap/features/music/widgets/playback_controls_widget.dart';
// ... etc
```

## Widget Reference

### 1. AlbumArtWidget

Displays album artwork with glowing effects.

```dart
AlbumArtWidget(
  image: 'assets/album_cover.png',
  color: Colors.purple,
  isPlaying: true,
)
```

**Props:**
- `image` (String): Path to album image
- `color` (Color): Theme color for glow effect
- `isPlaying` (bool): Animation state

---

### 2. SongInfoWidget

Displays song title and artist name.

```dart
SongInfoWidget(
  title: 'Song Title',
  description: 'Artist Name - Album',
)
```

**Props:**
- `title` (String): Song title
- `description` (String): Artist/album info

---

### 3. ProgressBarWidget

Custom progress slider with time display.

```dart
ProgressBarWidget(
  currentPosition: 95.0,  // seconds
  totalDuration: 258.0,   // seconds
  color: Colors.purple,
)
```

**Props:**
- `currentPosition` (double): Current playback position in seconds
- `totalDuration` (double): Total song duration in seconds
- `color` (Color): Slider accent color

---

### 4. AudioVisualizerWidget ⭐ NEW

Animated audio visualizer with bars showing playback progress.

```dart
AudioVisualizerWidget(
  currentPosition: 95.0,  // seconds
  totalDuration: 258.0,   // seconds
  color: Colors.purple,
  isPlaying: true,
)
```

**Props:**
- `currentPosition` (double): Current playback position in seconds
- `totalDuration` (double): Total song duration in seconds
- `color` (Color): Bar color for played portion
- `isPlaying` (bool): Controls animation state

**Features:**
- 50 animated vertical bars
- Bars pulse when playing, static when paused
- Color changes based on progress (purple = played, gray = remaining)
- Time labels at bottom (current / total)

---

### 5. PlaybackControlsWidget

Main playback control buttons.

```dart
PlaybackControlsWidget(
  isPlaying: true,
  onPlayPause: () {
    // Toggle play/pause
  },
  onPrevious: () {
    // Previous track
  },
  onNext: () {
    // Next track
  },
  color: Colors.purple,
)
```

**Props:**
- `isPlaying` (bool): Current playback state
- `onPlayPause` (VoidCallback): Play/pause handler
- `onPrevious` (VoidCallback): Previous track handler
- `onNext` (VoidCallback): Next track handler
- `color` (Color): Button accent color

**Features:**
- Previous/Next skip buttons
- Large glowing play/pause button
- Simplified, clean design

---

### 6. ActionButtonsWidget

Secondary action buttons (like, shuffle, repeat).

```dart
ActionButtonsWidget(
  color: Colors.purple,
)
```

**Props:**
- `color` (Color): Active state color

**Features:**
- Like/Favorite toggle
- Shuffle toggle
- Repeat mode toggle
- More options button

---

### 7. AudioQualityBadge

Displays audio format information.

```dart
AudioQualityBadge(
  quality: 'FLAC 24-bit / 96 kHz',
  color: Colors.purple,
)
```

**Props:**
- `quality` (String): Audio quality text
- `color` (Color): Badge accent color

---

### 8. MiniPlayerWidget

Collapsed player for navigation.

```dart
MiniPlayerWidget(
  title: 'Song Title',
  image: 'assets/album.png',
  description: 'Artist Name',
  color: Colors.purple,
  isPlaying: true,
  onTap: () {
    // Expand to full player
  },
  onPlayPause: () {
    // Toggle play/pause
  },
  onPrevious: () {
    // Previous track
  },
  onNext: () {
    // Next track
  },
)
```

**Props:**
- `title` (String): Song title
- `image` (String): Album art path
- `description` (String): Artist info
- `color` (Color): Background gradient color
- `isPlaying` (bool): Playback state
- `onTap` (VoidCallback): Tap to expand
- `onPlayPause` (VoidCallback): Play/pause handler
- `onPrevious` (VoidCallback): Previous handler
- `onNext` (VoidCallback): Next handler

---

### 9. SongCard

List item for song in playlist/library.

```dart
SongCard(
  title: 'Song Title',
  artist: 'Artist Name',
  imageUrl: 'assets/album.png',
  color: Colors.purple,
  isPlaying: false,
  onTap: () {
    // Play this song
  },
)
```

**Props:**
- `title` (String): Song title
- `artist` (String): Artist name
- `imageUrl` (String): Album art
- `color` (Color): Theme color
- `isPlaying` (bool): Highlight if currently playing
- `onTap` (VoidCallback): Tap handler

---

## Complete Example

Here's how all widgets work together in `PlayNowScreen`:

```dart
import 'package:flutter/material.dart';
import 'package:sonic_snap/features/music/widgets/widgets.dart';

class PlayNowScreen extends StatefulWidget {
  final String title;
  final String image;
  final Color color;
  final String description;
  // ... callbacks
  
  @override
  State<PlayNowScreen> createState() => _PlayNowScreenState();
}

class _PlayNowScreenState extends State<PlayNowScreen> {
  bool isPlaying = true;
  double currentPosition = 55;
  double totalDuration = 258;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              widget.color.withOpacity(0.3),
              Colors.black,
            ],
          ),
        ),
        child: Column(
          children: [
            // Album Art
            AlbumArtWidget(
              image: widget.image,
              color: widget.color,
              isPlaying: isPlaying,
            ),
            
            // Song Info
            SongInfoWidget(
              title: widget.title,
              description: widget.description,
            ),
            
            // Action Buttons
            ActionButtonsWidget(color: widget.color),
            
            // Progress Bar
            ProgressBarWidget(
              currentPosition: currentPosition,
              totalDuration: totalDuration,
              color: widget.color,
            ),
            
            // Playback Controls
            PlaybackControlsWidget(
              isPlaying: isPlaying,
              onPlayPause: () {
                setState(() => isPlaying = !isPlaying);
              },
              onPrevious: widget.onPrevious,
              onNext: widget.onNext,
              color: widget.color,
            ),
            
            // Quality Badge
            AudioQualityBadge(
              quality: 'FLAC 24-bit / 96 kHz',
              color: widget.color,
            ),
          ],
        ),
      ),
    );
  }
}
```

## Design Principles

### Colors
- Use dynamic colors based on album art
- Apply opacity for depth (0.2 - 0.8 range)
- Consistent accent colors throughout

### Spacing
- Standard padding: 16-24px
- Component spacing: 20-30px
- Icon sizes: 24-48px

### Animations
- Default duration: 300ms
- Use cubic curves for smoothness
- Subtle hover/tap feedback

### Accessibility
- Minimum touch target: 44x44px
- Sufficient color contrast
- Clear visual feedback

---

**Need Help?** Check the individual widget files for more implementation details!

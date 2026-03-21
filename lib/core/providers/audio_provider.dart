import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sonic_snap/data/dummy_data.dart';

class AudioState {
  final List<Map<String, dynamic>> playlist;
  final int selectedSongIndex;
  final bool isPlaying;
  final bool isPlayerExpanded;

  AudioState({
    required this.playlist,
    this.selectedSongIndex = 0,
    this.isPlaying = false,
    this.isPlayerExpanded = false,
  });

  AudioState copyWith({
    List<Map<String, dynamic>>? playlist,
    int? selectedSongIndex,
    bool? isPlaying,
    bool? isPlayerExpanded,
  }) {
    return AudioState(
      playlist: playlist ?? this.playlist,
      selectedSongIndex: selectedSongIndex ?? this.selectedSongIndex,
      isPlaying: isPlaying ?? this.isPlaying,
      isPlayerExpanded: isPlayerExpanded ?? this.isPlayerExpanded,
    );
  }
}

class AudioNotifier extends Notifier<AudioState> {
  @override
  AudioState build() {
    return AudioState(playlist: dummySongs, selectedSongIndex: 0, isPlaying: false, isPlayerExpanded: false);
  }

  void playSong(int index, {List<Map<String, dynamic>>? newPlaylist}) {
    state = state.copyWith(
      playlist: newPlaylist ?? state.playlist,
      selectedSongIndex: index, 
      isPlaying: true
    );
  }

  void togglePlayPause() {
    state = state.copyWith(isPlaying: !state.isPlaying);
  }

  void nextSong() {
    if (state.playlist.isEmpty) return;
    final nextIndex = (state.selectedSongIndex + 1) % state.playlist.length;
    state = state.copyWith(selectedSongIndex: nextIndex);
  }

  void previousSong() {
    if (state.playlist.isEmpty) return;
    final prevIndex = (state.selectedSongIndex - 1 + state.playlist.length) % state.playlist.length;
    state = state.copyWith(selectedSongIndex: prevIndex);
  }

  void togglePlayer() {
    state = state.copyWith(isPlayerExpanded: !state.isPlayerExpanded);
  }
}

final audioProvider = NotifierProvider<AudioNotifier, AudioState>(() {
  return AudioNotifier();
});

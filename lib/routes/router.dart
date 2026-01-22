import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sonic_snap/features/home/view/home_screen.dart';
import 'package:sonic_snap/features/music/view/search_screen.dart';
import 'package:sonic_snap/features/splash/view/appscreen.dart';

import 'package:sonic_snap/features/music/view/album_details_screen.dart';
import 'package:sonic_snap/features/settings/view/settings_screen.dart';
import 'package:sonic_snap/features/settings/view/equalizer_screen.dart';
import 'package:sonic_snap/features/settings/view/storage_settings_screen.dart';
import 'package:sonic_snap/features/settings/view/sleep_timer_screen.dart';

class AppRouter {
  static const String splashScreen = "/";
  static const String homeScreen = "/home-screen";
  static const String searchScreen = "/search-screen";
  static const String albumScreen = "/album-screen";
  static const String artistScreen = "/artist-screen";
  static const String playNowScreen = "/play-now-screen";
  static const String settingsScreen = "/settings-screen";
  static const String equalizerScreen = "/equalizer-screen";
  static const String storageScreen = "/storage-screen";
  static const String sleepTimerScreen = "/sleep-timer-screen";

  static final router = GoRouter(
    initialLocation: splashScreen,
    routes: [
      GoRoute(
        path: splashScreen,
        builder: (context, state) => const AppScreen(),
      ),
      GoRoute(
        path: homeScreen,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: searchScreen,
        builder: (context, state) => const SearchScreen(),
      ),
      GoRoute(
        path: settingsScreen,
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: equalizerScreen,
        builder: (context, state) => const EqualizerScreen(),
      ),
      GoRoute(
        path: storageScreen,
        builder: (context, state) => const StorageSettingsScreen(),
      ),
      GoRoute(
        path: sleepTimerScreen,
        builder: (context, state) => const SleepTimerScreen(),
      ),
      GoRoute(
        path: albumScreen,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>? ?? {};
          return AlbumDetailsScreen(
            title: extra['title'] ?? 'Unknown Album',
            artist: extra['artist'] ?? 'Unknown Artist',
            image: extra['image'] ?? 'assets/logo/play_now.png',
          );
        },
      ),
    ],
  );
}

void navigate(BuildContext context, String route, {Object? extra}) {
  if (kIsWeb) {
    context.go(route, extra: extra);
  } else {
    context.push(route, extra: extra);
  }
}

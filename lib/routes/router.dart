import 'package:go_router/go_router.dart';
import 'package:todo/features/home/view/home_screen.dart';
import 'package:todo/features/splash/view/appscreen.dart';

class AppRouter {
  static const String splashScreen = "/";
  static const String homeScreen = "/home-screen";

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
      
    ],
  );
}

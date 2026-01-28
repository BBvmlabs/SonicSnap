import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sonic_snap/routes/router.dart';
import 'package:sonic_snap/widgets/beat_animation.dart';

class AppScreen extends StatefulWidget {
  const AppScreen({super.key});

  @override
  State<AppScreen> createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        context.go('/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PulseAnimation(
        child: Image.asset(
          'assets/logo/appscreen.png',
          width: 550,
        ),
      ),
    );
  }
}

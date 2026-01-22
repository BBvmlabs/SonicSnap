import 'package:flutter/material.dart';
import 'package:todo/features/music/view/play_now.dart';
import 'package:todo/widgets/app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: const CustomAppBar(),
      bottomNavigationBar: PlayNowScreen(
        title: "Play Now",
        image: "logo/play_now.png",
        description: "Play Now",
        onTap: () {},
        onPrevious: () {},
        onNext: () {},
        onPressed: () {},
        color: Colors.blue,
      ),
    );
  }
}

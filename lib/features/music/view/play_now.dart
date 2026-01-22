import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/features/music/widgets/song_card.dart';

class PlayNowScreen extends StatefulWidget {
  bool isScreen = true;
  final String title;
  final String image;
  final Color color;
  final String description;
  final Function() onTap;
  final Function() onPrevious;
  final Function() onNext;
  final Function() onPressed;
  PlayNowScreen(
      {super.key,
      required this.title,
      required this.image,
      required this.description,
      required this.onTap,
      required this.onPrevious,
      required this.onNext,
      required this.onPressed,
      required this.color});

  @override
  State<PlayNowScreen> createState() => _PlayNowScreenState();
}

class _PlayNowScreenState extends State<PlayNowScreen> {
  bool isPlaying = false;
  bool isBigScreen = false;

  void onTap() => setState(() {
        widget.isScreen = !widget.isScreen;
      });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (width > 600) {
      isBigScreen = true;
    }
    return widget.isScreen ? _fullPlayerScreen() : _smallPlayerScreen();
  }

  Widget _smallPlayerScreen() {
    return SizedBox(
      height: 60,
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: widget.color,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
        ),
        onPressed: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(widget.image),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(widget.description),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                IconButton(
                    onPressed: widget.onPrevious,
                    icon: const Icon(
                      Icons.skip_previous,
                      size: 30,
                    )),
                IconButton(
                    onPressed: () {
                      setState(() {
                        isPlaying = !isPlaying;
                      });
                      widget.onPressed;
                    },
                    icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow,
                        size: 30)),
                IconButton(
                    onPressed: widget.onNext,
                    icon: const Icon(
                      Icons.skip_next,
                      size: 30,
                    )),
                IconButton(
                    onPressed: widget.onNext,
                    icon: const Icon(
                      Icons.playlist_play,
                      size: 30,
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _fullPlayerScreen() {
    return Center(
        child: Wrap(
      alignment: WrapAlignment.center,
      direction: isBigScreen ? Axis.vertical : Axis.horizontal,
      children: [
        _songCard(path: widget.image),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.favorite,
                  color: Colors.white,
                  size: 20,
                )),
            IconButton(onPressed: () {}, icon: const Icon(Icons.share))
          ],
        ),
        Row(
          children: [
            IconButton(
                onPressed: widget.onPrevious,
                icon: const Icon(
                  Icons.skip_previous,
                  size: 30,
                )),
            IconButton(
                onPressed: () {
                  setState(() {
                    isPlaying = !isPlaying;
                  });
                  widget.onPressed;
                },
                icon:
                    Icon(isPlaying ? Icons.pause : Icons.play_arrow, size: 30)),
            IconButton(
                onPressed: widget.onNext,
                icon: const Icon(
                  Icons.skip_next,
                  size: 30,
                )),
            IconButton(
                onPressed: widget.onNext,
                icon: const Icon(
                  Icons.playlist_play,
                  size: 30,
                )),
          ],
        ),
      ],
    ));
  }

  List<Widget> _songDetails() => [
        Text(widget.title,
            style: const TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.w500)),
        Text(widget.description,
            style: const TextStyle(fontSize: 20, color: Colors.white)),
      ];

  Widget _songCard({required String path}) {
    return Image.asset(
      path,
    );
  }
}

import 'package:flutter/material.dart';

class ActionButtonsWidget extends StatefulWidget {
  final Color color;

  const ActionButtonsWidget({
    super.key,
    required this.color,
  });

  @override
  State<ActionButtonsWidget> createState() => _ActionButtonsWidgetState();
}

class _ActionButtonsWidgetState extends State<ActionButtonsWidget> {
  bool isLiked = false;
  bool isShuffled = false;
  bool isRepeat = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Like button
        IconButton(
          onPressed: () {
            setState(() {
              isLiked = !isLiked;
            });
          },
          icon: Icon(
            isLiked ? Icons.favorite : Icons.favorite_border,
            color: isLiked ? Colors.redAccent : Colors.white.withOpacity(0.7),
            size: 28,
          ),
        ),

        // Shuffle button
        IconButton(
          onPressed: () {
            setState(() {
              isShuffled = !isShuffled;
            });
          },
          icon: Icon(
            Icons.shuffle_rounded,
            color: isShuffled ? widget.color : Colors.white.withOpacity(0.7),
            size: 24,
          ),
        ),

        // Repeat button
        IconButton(
          onPressed: () {
            setState(() {
              isRepeat = !isRepeat;
            });
          },
          icon: Icon(
            isRepeat ? Icons.repeat_one_rounded : Icons.repeat_rounded,
            color: isRepeat ? widget.color : Colors.white.withOpacity(0.7),
            size: 24,
          ),
        ),

        // More options button
        IconButton(
          onPressed: () {
            // Show bottom sheet with more options
          },
          icon: Icon(
            Icons.more_vert_rounded,
            color: Colors.white.withOpacity(0.7),
            size: 24,
          ),
        ),
      ],
    );
  }
}

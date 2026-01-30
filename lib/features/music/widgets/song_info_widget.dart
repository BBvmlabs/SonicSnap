import 'package:flutter/material.dart';

class SongInfoWidget extends StatelessWidget {
  final String title;
  final String description;

  const SongInfoWidget({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final isWideScreen = MediaQuery.of(context).size.width > 600;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontSize: isWideScreen ? 42 : 28,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: isWideScreen ? 16 : 8),
        Text(
          description,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                fontSize: isWideScreen ? 24 : 16,
                color: Colors.white.withOpacity(0.7),
                fontWeight: FontWeight.w400,
              ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

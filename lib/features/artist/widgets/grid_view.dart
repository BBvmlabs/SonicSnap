import 'package:flutter/material.dart';
import 'package:sonic_snap/widgets/grid_view.dart';

class ArtistGridWidget extends StatefulWidget {
  const ArtistGridWidget({super.key});

  @override
  State<ArtistGridWidget> createState() => _ArtistGridWidgetState();
}

class _ArtistGridWidgetState extends State<ArtistGridWidget> {
  @override
  Widget build(BuildContext context) {
    return AppGridView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return GridTile(
          child: Column(
            children: [
              Image.network(
                'https://picsum.photos/200',
                height: 100,
                width: 100,
              ),
              Text('Album $index'),
              Text('10 songs'),
            ],
          ),
        );
      },
    );
  }
}
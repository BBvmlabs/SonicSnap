import 'package:flutter/material.dart';
import 'package:sonic_snap/features/artist/widgets/grid_view.dart';

class ArtistListView extends StatefulWidget {
  const ArtistListView({super.key});

  @override
  State<ArtistListView> createState() => _ArtistListViewState();
}

class _ArtistListViewState extends State<ArtistListView> {
  @override
  Widget build(BuildContext context) {
    return const ArtistGridWidget();
  }
}
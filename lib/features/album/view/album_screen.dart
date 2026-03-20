import 'package:flutter/material.dart';
import 'package:sonic_snap/features/album/widgets/grid_view.dart';

class AlbumScreen extends StatefulWidget {
  const AlbumScreen({super.key});

  @override
  State<AlbumScreen> createState() => _AlbumScreenState();
}

class _AlbumScreenState extends State<AlbumScreen> {
  @override
  Widget build(BuildContext context) {
    final isBigScreen = MediaQuery.of(context).size.width > 900;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: isBigScreen
          ? _buildBigScreenLayout()
          : _buildSmallScreenLayout(context),
    );
  }

  Widget _buildBigScreenLayout() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTopUtilityBar(),
          const AlbumGridWidget(),
          const SizedBox(height: 100), // Space for mini player
        ],
      ),
    );
  }

  Widget _buildSmallScreenLayout(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 12),
              child: Text(
                'ALBUMS',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -1.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _buildSearchZone(),
            ),
            const AlbumGridWidget(),
            const SizedBox(height: 100), // Space for mini player
          ],
        ),
      ),
    );
  }

  Widget _buildTopUtilityBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 32, 40, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'ALBUMS',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 56,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -2.0,
                ),
              ),
              const Spacer(),
              SizedBox(
                width: 300,
                child: _buildSearchZone(),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Text(
                'SORT BY: RECENTLY ADDED',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(width: 8),
              Icon(Icons.tune_rounded, color: Colors.grey[600], size: 16),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchZone() {
    return TextField(
      textInputAction: TextInputAction.search,
      style: const TextStyle(
          color: Colors.white,
          fontSize: 13,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.0),
      decoration: InputDecoration(
        fillColor: const Color(0xFF161B22),
        filled: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.cyanAccent.shade400, width: 1),
        ),
        hintText: "SEARCH...",
        hintStyle: TextStyle(
            color: Colors.grey[600],
            fontSize: 13,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.5),
        prefixIcon: Icon(Icons.search, color: Colors.grey[600], size: 18),
      ),
    );
  }
}

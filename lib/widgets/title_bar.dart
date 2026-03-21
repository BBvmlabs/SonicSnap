import 'package:flutter/material.dart';

Widget buildTitleBar(String title, {bool isSmallScreen = false}) {
  return Padding(
    padding: EdgeInsets.fromLTRB(
        isSmallScreen ? 20 : 40, isSmallScreen ? 10 : 32, 40, 0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: isSmallScreen ? 46 : 56,
                fontWeight: FontWeight.w900,
                letterSpacing: -2.0,
              ),
            ),
            const Spacer(),
            if (!isSmallScreen) Expanded(child: _buildSearchZone()),
          ],
        ),
        if (!isSmallScreen)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
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
                      Icon(Icons.tune_rounded,
                          color: Colors.grey[600], size: 16),
                    ],
                  )),
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
      ));
}

Widget buildMobileTitleBar(BuildContext context, IconData icon, String title) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
    child: Row(children: [
      Icon(icon, color: Colors.white, size: 30),
      const SizedBox(width: 10),
      Text(
        title,
        style: Theme.of(context).textTheme.headlineLarge,
      )
    ]),
  );
}

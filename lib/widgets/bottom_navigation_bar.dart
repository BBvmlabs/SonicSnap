import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {

  final Widget child;
  final Function() onTap;

  const BottomBar({
    super.key,
    required this.child,
    required this.onTap,
  });

  @override
  State<BottomBar> createState() =>
      _BottomBarState();
}

class _BottomBarState
    extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final bool isSmallScreen = width < 600;
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 65,
        width: isSmallScreen ? double.infinity : 600,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: widget.child,
      ),
    );
  }
}

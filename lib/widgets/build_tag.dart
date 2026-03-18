import 'package:flutter/material.dart';

Widget buildTag(String label, {Color? color}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: color ?? Colors.teal.shade900.withValues(alpha: 0.3),
        border: Border.all(color: Colors.white10),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white38,
          fontSize: 9,
          fontWeight: FontWeight.w900,
          letterSpacing: 1.0,
        ),
      ),
    );
  }
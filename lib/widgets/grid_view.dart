import 'package:flutter/material.dart';

class AppGridView extends StatefulWidget {
  final List<dynamic> items;
  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;

  const AppGridView({
    super.key,
    required this.items,
    required this.itemCount,
    required this.itemBuilder,
  });

  @override
  State<AppGridView> createState() => _AppGridViewState();

  static Widget builder({
    required int itemCount,
    required Widget Function(BuildContext context, int index) itemBuilder,
  }) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: itemCount,
      itemBuilder: itemBuilder,
    );
  }
}

class _AppGridViewState extends State<AppGridView> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: widget.itemCount,
      itemBuilder: widget.itemBuilder,
    );
  }
}

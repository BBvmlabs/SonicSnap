import 'package:flutter/material.dart';

class AppListView extends StatefulWidget {
  final List<dynamic> items;
  final int itemCount;
  final ListTile Function(BuildContext, int) itemBuilder;

  const AppListView({
    super.key,
    required this.items,
    required this.itemCount,
    required this.itemBuilder,
  });

  @override
  State<AppListView> createState() => _AppListViewState();

  static Widget builder({
    required int itemCount,
    required ListTile Function(BuildContext context, int index) itemBuilder,
  }) {
    return ListView.builder(
      itemCount: itemCount,
      itemBuilder: itemBuilder,
    );
  }
}

class _AppListViewState extends State<AppListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.itemCount,
      itemBuilder: widget.itemBuilder,
    );
  }
}

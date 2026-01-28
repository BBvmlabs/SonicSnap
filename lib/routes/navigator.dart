import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void navigate(BuildContext context, String route, {Object? extra}) {
  if (kIsWeb) {
    context.go(route, extra: extra);
  } else {
    context.push(route, extra: extra);
  }
}

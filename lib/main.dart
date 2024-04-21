import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'screen/home_screen.dart';

void main() {
  runApp(const ProviderScope(
      child: (MaterialApp(
    home: HomeScreen(),
  ))));
}

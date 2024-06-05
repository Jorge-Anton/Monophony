import 'package:flutter/material.dart';

class ViewController {
  final activeViewNotifier = ValueNotifier(0);

  void changeView(int view) {
    activeViewNotifier.value = view;
  }

  void dispose() {
    activeViewNotifier.dispose();
  }
}
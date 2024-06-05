import 'package:flutter/material.dart';

class FabController {
  final showFabNotifier = ValueNotifier(true);

  void showFab() {
    showFabNotifier.value = true;
  }

  void hideFab() {
    showFabNotifier.value = false;
  }
}
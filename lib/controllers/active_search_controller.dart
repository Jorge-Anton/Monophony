import 'package:flutter/material.dart';

class ActiveSearchController {
  final activeSearchNotifier = ValueNotifier('');

  void setActiveSearch(String query) {
    activeSearchNotifier.value = query;
  }
}
import 'package:flutter/material.dart';

class ViewNotifier extends ValueNotifier<int> {
  ViewNotifier() : super(0);

  void changeView(int view) {
    value = view;
  }
}
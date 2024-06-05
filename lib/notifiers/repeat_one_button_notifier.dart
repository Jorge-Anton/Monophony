import 'package:flutter/foundation.dart';

class RepeatOneButtonNotifier extends ValueNotifier<bool> {
  RepeatOneButtonNotifier() : super(false);

  void nextState() {
    value = !value;
  }
}
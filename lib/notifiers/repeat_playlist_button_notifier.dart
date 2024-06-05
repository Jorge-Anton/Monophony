import 'package:flutter/foundation.dart';

class RepeatPlaylistButtonNotifier extends ValueNotifier<bool> {
  RepeatPlaylistButtonNotifier() : super(false);

  void nextState() {
    value = !value;
  }
}
import 'package:flutter/material.dart';
import 'package:miniplayer/miniplayer.dart';

class MyMiniPlayerController {
  final playerExpandProgress = ValueNotifier<double>(70);
  final dragDownPercentageNotifier = ValueNotifier<double>(1);

  final MiniplayerController controller = MiniplayerController();
}
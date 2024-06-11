import 'package:flutter/material.dart';
import 'package:monophony/controllers/mini_player_controller.dart';
import 'package:monophony/services/service_locator.dart';
import 'package:monophony/widgets/fabs/hide_on_scroll_fab.dart';

class RadioFab extends StatelessWidget {
  const RadioFab({
    super.key,
    required this.showFabNotifier,
    required this.onPressed
  });

  final ValueNotifier<bool> showFabNotifier;
  final void Function() onPressed;
  static final MyMiniPlayerController myMiniPlayerController = getIt<MyMiniPlayerController>();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: myMiniPlayerController.dragDownPercentageNotifier, 
      builder: (context, value, child) {
        return Padding(
          padding: EdgeInsets.only(bottom: 70 - 70 * value),
          child: HideOnScrollFab(
            showFabNotifier: showFabNotifier, 
            onPressed: () {
              onPressed();
            },
            child: const Icon(Icons.cell_tower_rounded)
          ),
        );
      },
    );
  }
}
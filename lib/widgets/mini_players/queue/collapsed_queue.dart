import 'package:flutter/material.dart';
import 'package:miniplayer/miniplayer.dart';

class CollapsedQueue extends StatelessWidget {
  const CollapsedQueue({
    super.key,
    required this.controller
  });

  final MiniplayerController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: 60,
          width: MediaQuery.of(context).size.width,
          child: IconButton.filledTonal(
            onPressed: () {
              controller.animateToHeight(
                height: MediaQuery.of(context).size.height,
                duration: Durations.medium2,
              );
            },
            style: ButtonStyle(
              shape: MaterialStateProperty.all(const RoundedRectangleBorder(borderRadius: BorderRadius.zero))
            ),
            icon: const Icon(Icons.queue_music_rounded)
          ),
        ),
        Positioned(
          right: 2,
          child: IconButton(
            onPressed: () {}, 
            icon: const Icon(Icons.more_horiz_rounded),
            iconSize: 28.0,
          ),
        )
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:monophony/widgets/mini_players/queue/collapsed_queue.dart';
import 'package:monophony/widgets/mini_players/queue/expanded_queue.dart';

class QueueMiniPlayer extends StatelessWidget {
  const QueueMiniPlayer({super.key});

  static final _controller = MiniplayerController();

  @override
  Widget build(BuildContext context) {
    return Miniplayer(
      controller: _controller,
      minHeight: 60, 
      maxHeight: MediaQuery.of(context).size.height,
      tapToCollapse: false,
      builder: (height, percentage) {
        if (height <= 60) {
          return CollapsedQueue(controller: _controller,);
        } else {
          return ExpandedQueue(
            controller: _controller,
            height: height
          );
        }
      },
    );
  }
}

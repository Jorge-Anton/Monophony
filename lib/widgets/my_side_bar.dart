import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:monophony/notifiers/view_notifier.dart';
import 'package:monophony/models/destination_info_model.dart';

class MySideBar extends StatelessWidget {
  const MySideBar({
    super.key, 
    required this.actionButton,
    required this.destinations,
    required this.viewNotifer
  });

  final Widget actionButton;
  final List<DestinationInfoModel> destinations;
  final ViewNotifier viewNotifer;

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).viewPadding.top;
    return Padding(
      padding: EdgeInsets.only(top: statusBarHeight + 32.0, left: 6.0, right: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Transform.translate(
            offset: const Offset(4, 0),
            child: RotatedBox(
              quarterTurns: 3,
              child: actionButton,
            ),
          ),
          const SizedBox(height: 50.0),
          for (final destination in destinations)
          ValueListenableBuilder<int>(
            valueListenable: viewNotifer, 
            builder: (context, value, child) {
              return RotatedBox(
                quarterTurns: 3,
                child: TextButton(
                  onPressed: () {
                    final index = destinations.indexOf(destination);
                    viewNotifer.changeView(index);
                  }, 
                  child: Column(
                    children: [
                      AnimatedSlide(
                        offset: Offset(0, value == destinations.indexOf(destination) ? 0 : -2.7), 
                        duration: Durations.short3,
                        curve: Curves.ease,
                        child: FaIcon(
                          destination.iconName,
                          size: 10,
                          color: value == destinations.indexOf(destination) ? Colors.white : Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      Text(
                        destination.name,
                        style: TextStyle(
                          color: value == destinations.indexOf(destination) ? Colors.white : Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  )
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

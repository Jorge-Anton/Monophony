import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OptionsButton extends StatelessWidget {
  const OptionsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        debugPrint('options');
      }, 
      icon: const FaIcon(
        FontAwesomeIcons.sliders,
        size: 18
      )
    );
  }
}
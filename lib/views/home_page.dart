import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:monophony/widgets/my_text_field.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static final TextEditingController _controller = TextEditingController(text: 'Inicio');

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).viewPadding.top;
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: statusBarHeight + 30.0, right: 10.0),
            child: Align(
              alignment: Alignment.topRight,
              child: Column(
                children: [
                  MyTextField(
                    controller: _controller,
                    readOnly: true,
                    enabled: false,
                  )
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                iconSize: 16,
                visualDensity: const VisualDensity(horizontal: -2, vertical: -2),
                onPressed: () {}, 
                icon: FaIcon(
                  FontAwesomeIcons.arrowTrendUp,
                  color: Theme.of(context).colorScheme.secondary,
                )
              ),
              IconButton(
                iconSize: 16,
                visualDensity: const VisualDensity(horizontal: -2, vertical: -2),
                onPressed: () {}, 
                icon: FaIcon(
                  FontAwesomeIcons.font,
                  color: Theme.of(context).colorScheme.secondary,
                )
              ),
              IconButton(
                visualDensity: const VisualDensity(horizontal: -2, vertical: -2),
                iconSize: 16,
                onPressed: () {},
                icon: FaIcon(
                  FontAwesomeIcons.solidClock,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              IconButton(
                iconSize: 16,
                onPressed: () {},
                icon: FaIcon(
                  FontAwesomeIcons.arrowUp,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              )
            ],
          ),
          const Center(
            child: Text(
              'Aquí aparecerán tus recomendaciones, para ello comienza a escuchar música',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500
              ),
            ),
          )
        ],
      ),
    );
  }
}
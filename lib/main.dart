import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:monophony/controllers/audio_controller.dart';
import 'package:monophony/controllers/scaffold_controller.dart';
import 'package:monophony/notifiers/dominant_color_controller.dart';
import 'package:monophony/controllers/fab_controller.dart';
import 'package:monophony/notifiers/view_notifier.dart';
import 'package:monophony/services/service_locator.dart';
import 'package:monophony/views/my_page_view.dart';
import 'package:monophony/views/root_views.dart';
import 'package:monophony/widgets/fabs/search_fab.dart';
import 'package:monophony/widgets/mini_players/my_mini_player.dart';
import 'package:monophony/widgets/my_side_bar.dart';
import 'package:monophony/widgets/options_button.dart';

void main() async {
  await setupServiceLocator();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final DraggableScrollableController sheetController = DraggableScrollableController();
  late Color dominantColor;
  final DominantColorNotifier dominantColorController = getIt<DominantColorNotifier>();
  final AudioController audioController = getIt<AudioController>();
  
  @override
  void initState() {
    super.initState();
    dominantColor = dominantColorController.value;
    audioController.init();
    audioController.currentSongNotifier.addListener(() {
      final String? url = audioController.currentSongNotifier.value?.artUri.toString();
      if (url != null) {
        dominantColorController.getImagePalette(CachedNetworkImageProvider('$url-w60-h60'));
      } else {
        dominantColorController.resetPalette();
      }
    });
    dominantColorController.addListener(() {
      setState(() {
        dominantColor = dominantColorController.value;
      });
    });
  }

  @override
  void dispose() {
    audioController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorSchemeSeed: dominantColor,
        useMaterial3: true,
        brightness: Brightness.dark,
        fontFamily: 'Poppins'
      ),
      home: const OverlayPage(),
    );
  }
}

class MyRootPage extends StatelessWidget {
  const MyRootPage({super.key});

  static final ViewNotifier _viewNotifier = ViewNotifier();
  static final PageController _pageController = PageController();
  static final FabController _fabController = FabController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: getIt<ScaffoldController>().generalScaffoldKey,
      resizeToAvoidBottomInset: false,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          MySideBar(
            actionButton: const OptionsButton(),
            viewNotifer: _viewNotifier,
            destinations: rootDestinations,
          ),
          Expanded(
            child: NotificationListener<UserScrollNotification>(
              onNotification: (notification) {
                final ScrollDirection direction = notification.direction;
                if (direction == ScrollDirection.reverse) {
                  _fabController.hideFab();
                } else if (direction == ScrollDirection.forward) {
                  _fabController.showFab();
                }
                return true;
              },
              child: MyPageView(
                views: rootViews,
                pageController: _pageController,
                viewNotifier: _viewNotifier,
              ),
            )
          )
        ],
      ),
      floatingActionButton: SearchFab(showFabNotifier: _fabController.showFabNotifier),
    );
  }
}

class OverlayPage extends StatelessWidget {
  const OverlayPage({super.key});

  static final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MiniplayerWillPopScope(
      onWillPop: () async {
        final NavigatorState navigator = navigatorKey.currentState!;
        if (!navigator.canPop()) return true;
        navigator.pop();

        return false;
      },
      child: Scaffold(
        key: getIt<ScaffoldController>().overlayScaffoldKey,
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: <Widget>[
            Navigator(
              key: navigatorKey,
              onGenerateRoute: (RouteSettings settings) => MaterialPageRoute(
                settings: settings,
                builder: (BuildContext context) => const MyRootPage(),
              ),
            ),
            const MyMiniPlayer()
          ],
        ),
      ),
    );
  }
}
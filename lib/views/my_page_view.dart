import 'package:flutter/material.dart';
import 'package:monophony/controllers/view_controller.dart';

// class MyPageView extends StatelessWidget {
//   const MyPageView({
//     super.key,
//     required this.views,
//     required this.pageController,
//     required this.viewController
//   });

//   final ViewController viewController;
//   final List<Widget> views;
//   final PageController pageController;

//   @override
//   Widget build(BuildContext context) {
//     bool firstTime = true;

//     List<Widget> createPageContents() {
//       return views;
//     }

//     List<Widget> pageViews = createPageContents();
//     List<Widget> visiblePageViews = createPageContents();

//     void refreshChildren(Duration duration) {
//       visiblePageViews = createPageContents();
//     }

//     void swapChildren(int pageCurrent, int pageTarget) {
//       List<Widget> newVisiblePageViews = [];
//       newVisiblePageViews.addAll(pageViews);

//       if (pageTarget > pageCurrent) {
//         newVisiblePageViews[pageCurrent + 1] = visiblePageViews[pageTarget];
//       } else if (pageTarget < pageCurrent) {
//         newVisiblePageViews[pageCurrent - 1] = visiblePageViews[pageTarget];
//       }

//       visiblePageViews = newVisiblePageViews;
//     }

//     Future quickJump(int pageCurrent, int pageTarget) async {
//       int quickJumpTarget = pageCurrent;

//       if (pageTarget > pageCurrent) {
//         quickJumpTarget = pageCurrent + 1;
//       } else if (pageTarget < pageCurrent) {
//         quickJumpTarget = pageCurrent - 1;
//       }
//       await pageController.animateToPage(
//         quickJumpTarget,
//         curve: Curves.ease,
//         duration: Durations.medium4,
//       );
//       pageController.jumpToPage(pageTarget);
//     }

//     void flashToPage(int pageTarget) async {
//       int pageCurrent = pageController.page!.round();
//       if (pageCurrent == pageTarget){
//         return;
//       }
//       swapChildren(pageCurrent, pageTarget);
//       await quickJump(pageCurrent, pageTarget);
//       WidgetsBinding.instance.addPostFrameCallback(refreshChildren);
//     }

//     return ValueListenableBuilder(
//       valueListenable: viewController.activeViewNotifier, 
//       builder: (context, value, child) {
//         if (!firstTime) {
//           flashToPage(value);
//         }
//         firstTime = false;

//         return PageView(
//           physics: const NeverScrollableScrollPhysics(),
//           scrollDirection: Axis.vertical,
//           controller: pageController,
//           children: <Widget>[
//             ...visiblePageViews
//           ],
//         );
//       },
//     );
//   }
// }


class MyPageView extends StatefulWidget {
  final ViewController viewController;
  final PageController pageController;
  final List<Widget> views;
  const MyPageView({
    Key? key, 
    required this.viewController,
    required this.pageController,
    required this.views
  }) : super(key: key);

  @override
  State<MyPageView> createState() => _MyPageView1State();
}

class _MyPageView1State extends State<MyPageView> {
  late List<Widget> _pageViews;
  late List<Widget> _visiblePageViews;
  bool _firstTime = true;

  List<Widget> _createPageContents() {
    return widget.views;
  }

  @override
  void initState() {
    super.initState();
    _pageViews = _createPageContents();
    _visiblePageViews = _createPageContents();
    widget.viewController.activeViewNotifier.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    int activeView = widget.viewController.activeViewNotifier.value;

    if (!_firstTime) {
      flashToPage(activeView);
    }
    _firstTime = false;

    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      controller: widget.pageController,
      children: <Widget>[
        ..._visiblePageViews
      ],
    );
  }

  void refreshChildren(Duration duration) {
    setState(() {
      _visiblePageViews = _createPageContents();
    });
  }

  void flashToPage(int pageTarget) async {
    int pageCurrent = widget.pageController.page!.round();
    if (pageCurrent == pageTarget){
      return;
    }
    swapChildren(pageCurrent, pageTarget);
    await quickJump(pageCurrent, pageTarget);
    WidgetsBinding.instance.addPostFrameCallback(refreshChildren);
  }

  void swapChildren(int pageCurrent, int pageTarget) {
    List<Widget> newVisiblePageViews = [];
    newVisiblePageViews.addAll(_pageViews);

    if (pageTarget > pageCurrent) {
      newVisiblePageViews[pageCurrent + 1] = _visiblePageViews[pageTarget];
    } else if (pageTarget < pageCurrent) {
      newVisiblePageViews[pageCurrent - 1] = _visiblePageViews[pageTarget];
    }

    setState(() {
      _visiblePageViews = newVisiblePageViews;
    });
  }

  Future quickJump(int pageCurrent, int pageTarget) async {
    int quickJumpTarget = pageCurrent;

    if (pageTarget > pageCurrent) {
      quickJumpTarget = pageCurrent + 1;
    } else if (pageTarget < pageCurrent) {
      quickJumpTarget = pageCurrent - 1;
    }
    await widget.pageController.animateToPage(
      quickJumpTarget,
      curve: Curves.ease,
      duration: const Duration(milliseconds: 300),
    );
    widget.pageController.jumpToPage(pageTarget);
  }
}
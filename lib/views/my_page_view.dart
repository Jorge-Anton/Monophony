import 'package:flutter/material.dart';
import 'package:monophony/notifiers/view_notifier.dart';

class MyPageView extends StatelessWidget {
  const MyPageView({
    super.key,
    required this.views,
    required this.pageController,
    required this.viewNotifier
  });

  final ViewNotifier viewNotifier;
  final List<Widget> views;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    bool firstTime = true;

    List<Widget> createPageContents() {
      return views;
    }

    List<Widget> pageViews = createPageContents();
    List<Widget> visiblePageViews = createPageContents();

    void refreshChildren(Duration duration) {
      visiblePageViews = createPageContents();
    }

    void swapChildren(int pageCurrent, int pageTarget) {
      List<Widget> newVisiblePageViews = [];
      newVisiblePageViews.addAll(pageViews);

      if (pageTarget > pageCurrent) {
        newVisiblePageViews[pageCurrent + 1] = visiblePageViews[pageTarget];
      } else if (pageTarget < pageCurrent) {
        newVisiblePageViews[pageCurrent - 1] = visiblePageViews[pageTarget];
      }

      visiblePageViews = newVisiblePageViews;
    }

    Future quickJump(int pageCurrent, int pageTarget) async {
      int quickJumpTarget = pageCurrent;

      if (pageTarget > pageCurrent) {
        quickJumpTarget = pageCurrent + 1;
      } else if (pageTarget < pageCurrent) {
        quickJumpTarget = pageCurrent - 1;
      }
      await pageController.animateToPage(
        quickJumpTarget,
        curve: Curves.ease,
        duration: Durations.medium4,
      );
      pageController.jumpToPage(pageTarget);
    }

    void flashToPage(int pageTarget) async {
      int pageCurrent = pageController.page!.round();
      if (pageCurrent == pageTarget){
        return;
      }
      swapChildren(pageCurrent, pageTarget);
      await quickJump(pageCurrent, pageTarget);
      WidgetsBinding.instance.addPostFrameCallback(refreshChildren);
    }

    return ValueListenableBuilder(
      valueListenable: viewNotifier, 
      builder: (context, value, child) {
        if (!firstTime) {
          flashToPage(value);
        }
        firstTime = false;

        return PageView(
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          controller: pageController,
          children: <Widget>[
            ...visiblePageViews
          ],
        );
      },
    );
  }
}
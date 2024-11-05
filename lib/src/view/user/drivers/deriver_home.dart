import 'package:flutter/material.dart';
import 'package:animations/animations.dart';

import '../../Home/deriver_home_page.dart';
import '../../Orders/driver_new_orders.dart';
import '../../bottom_navy_bar.dart';
import 'deriver_profile.dart';

class DeriverHomeView extends StatefulWidget {
  const DeriverHomeView({super.key});

  static List<Widget> screens = [
    DeriverMyOrdersView(),
    DeriverHomePageView(),
    DeriverProfileView()
  ];

  @override
  State<DeriverHomeView> createState() => _DeriverHomeViewState();
}

class _DeriverHomeViewState extends State<DeriverHomeView> {
  int newIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavyBar(
          itemCornerRadius: 10,
          selectedIndex: newIndex,
          items: [
            BottomNavyBarItem(
              iconActive : 'assets/bottom/Paper-a.png',
              icon: 'assets/bottom/Paper.png',
            ),
            BottomNavyBarItem(
              iconActive : 'assets/bottom/Home-a.png',
              icon: 'assets/bottom/Home.png',
            ),
            BottomNavyBarItem(
              iconActive : 'assets/bottom/Profile-a.png',
              icon: 'assets/bottom/Profile.png',
            ),
          ],
          onItemSelected: (currentIndex) {
            newIndex = currentIndex;
            setState(() {});
          },
        ),
        body: PageTransitionSwitcher(
          duration: const Duration(seconds: 1),
          transitionBuilder: (
            Widget child,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) {
            return FadeThroughTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              child: child,
            );
          },
          child: DeriverHomeView.screens[newIndex],
        ),
      );
  }
}

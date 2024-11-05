import 'package:birdandroid/src/view/user/login_view.dart';
import 'package:birdandroid/utility/General.dart';
import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'Home/home_page.dart';
import 'Notification/notifications_view.dart';
import 'Orders/my_order_view.dart';
import 'Settings/profile_view.dart';
import 'bottom_navy_bar.dart';
import 'user/login_or_signapp.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});


  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int newIndex = 2;
   List<Widget> screens = [
    General.token.isEmpty?LoginView():MyOrdersView(),
    General.token.isEmpty?LoginView():NotificationsView(),
    HomePageView(),
    General.token.isEmpty?LoginView():ProfileView()
  ];

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
              iconActive : 'assets/bottom/Notification-a.png',
              icon: 'assets/bottom/Notification.png',
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
          child: screens[newIndex],
        ),
      );
  }
}

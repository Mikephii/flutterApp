import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      items: const [
        BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.graduationCap, size: 20),
            label: "Topics"),
        BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.bolt, size: 20), label: "About"),
        BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.userAstronaut, size: 20),
            label: "Profile")
      ],
      fixedColor: Colors.deepPurple[200],
      onTap: (int idx) {
        setState(() {
          currentIndex = idx;
        });
        switch (idx) {
          case 0:
            GoRouter.of(context).go('/');
            break;
          case 1:
            GoRouter.of(context).go('/about');
            break;
          case 2:
            GoRouter.of(context).go('/profile', extra: {'direction': 'home'});
            break;
        }
      },
    );
  }
}

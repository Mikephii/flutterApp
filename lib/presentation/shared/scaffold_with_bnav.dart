import 'package:buddybrew/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithBottomNav extends StatelessWidget {
  final Widget child;
  const ScaffoldWithBottomNav({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int currentIndex = 0;
  final destinations = ['/', '/about', '/login', '/profile'];
  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: currentIndex,
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Icon(Icons.search),
          label: 'About',
        ),
        NavigationDestination(
          icon: Icon(Icons.favorite),
          label: 'Login',
        ),
        NavigationDestination(
          icon: Icon(Icons.settings),
          label: 'Profile',
        ),
      ],
      onDestinationSelected: (int index) {
        PageTransitionDirection direction;
        if (index > currentIndex) {
          direction = PageTransitionDirection.rightToLeft;
        } else {
          direction = PageTransitionDirection.leftToRight;
        }
        setState(() {
          currentIndex = index;
        });
        GoRouter.of(context)
            .go(destinations[index], extra: Extra(direction: direction));
      },
    );
  }
}

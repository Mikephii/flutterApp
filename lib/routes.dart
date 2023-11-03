import 'package:buddybrew/presentation/screens/about/about.dart';
import 'package:buddybrew/presentation/screens/home/home.dart';
import 'package:buddybrew/presentation/screens/login/login.dart';
import 'package:buddybrew/presentation/screens/profile/profile.dart';
import 'package:buddybrew/presentation/shared/scaffold_with_bnav.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

// GoRouter configuration
final GoRouter goRoutes = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return ScaffoldWithBottomNav(child: child);
      },
      routes: [
        GoRoute(
          path: '/login',
          pageBuilder: (context, state) => slideTransition(
            context,
            state,
            child: const LoginScreen(),
          ),
        ),
        GoRoute(
          path: '/',
          pageBuilder: (context, state) => slideTransition(
            context,
            state,
            child: const HomeScreen(),
          ),
        ),
        GoRoute(
          path: '/about',
          pageBuilder: (context, state) => slideTransition(
            context,
            state,
            child: const AboutScreen(),
          ),
        ),
        GoRoute(
          path: '/profile',
          pageBuilder: (context, state) => slideTransition(
            context,
            state,
            child: const ProfileScreen(),
          ),
        ),
      ],
    )
  ],
);

enum PageTransitionDirection { leftToRight, rightToLeft }

class Extra {
  final PageTransitionDirection? direction;
  Extra({this.direction});
}

slideTransition(BuildContext context, GoRouterState state,
    {required Widget child}) {
  Extra? extra = state.extra as Extra?;
  PageTransitionDirection direction =
      extra?.direction ?? PageTransitionDirection.rightToLeft;

  return CustomTransitionPage<void>(
      transitionDuration: const Duration(milliseconds: 80),
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        Offset begin;
        if (direction == PageTransitionDirection.rightToLeft) {
          begin = const Offset(1.0, 0.0);
        } else {
          begin = const Offset(-1.0, 0.0);
        }
        const end = Offset.zero;
        final tween = Tween(begin: begin, end: end);
        final offsetAnimation = animation.drive(tween);
        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      });
}

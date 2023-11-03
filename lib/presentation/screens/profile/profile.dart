import 'package:buddybrew/services/supa_auth.dart';
import 'package:flutter/material.dart';
import 'package:buddybrew/services/auth.dart';
import 'package:buddybrew/presentation/shared/bottom_nav.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final router = GoRouter.of(context);
            await SupaAuthService().signOut();
            router.go('/');
          },
          child: const Text("sign out"),
        ),
      ),
    );
  }
}

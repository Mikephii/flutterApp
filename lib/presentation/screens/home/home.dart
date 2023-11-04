import 'package:buddybrew/services/auth_service/auth_service.dart';
import 'package:buddybrew/services/auth_service/supabase/supa_auth.dart';
import 'package:buddybrew/presentation/screens/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:buddybrew/presentation/screens/login/login.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthUser?>(
        stream: SupaAuthService().userStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("Something went wrong"));
          }

          if (snapshot.hasData && snapshot.data != null) {
            return const ProfileScreen();
          } else {
            return const LoginScreen();
          }
        });
  }
}

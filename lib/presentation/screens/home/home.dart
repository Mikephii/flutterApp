import 'package:buddybrew/services/supa_auth.dart';
import 'package:buddybrew/presentation/screens/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:buddybrew/presentation/screens/login/login.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthState>(
        stream: SupaAuthService().authStateStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("Something went wrong"));
          }

          if (snapshot.hasData && snapshot.data!.session != null) {
            return const ProfileScreen();
          } else {
            return const LoginScreen();
          }
        });
  }
}

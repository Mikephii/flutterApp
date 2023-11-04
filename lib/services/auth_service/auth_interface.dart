import 'package:supabase_flutter/supabase_flutter.dart' hide AuthUser;

import 'models/auth_user.dart';

abstract class AuthInterface {
  Stream<AuthUser?> get userStream;
  AuthUser? get currentUser;

  Future<void> signInWithEmailPassword(String email, String password);
  Future<void> signUpWithEmailPassword(String email, String password);
  Future<void> signOut();
  Future<void> signInWithGoogle();
}

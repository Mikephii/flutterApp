import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:buddybrew/main.dart';
import 'package:buddybrew/oauth_ids.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupaAuthService {
  final Stream<AuthState> authStateStream = supabase.auth
      .onAuthStateChange; //TODO: create own auth state stream to decouple from supabase

  final user = supabase.auth.currentUser;

  Future<AuthResponse> signInWithEmailPassword(String email, String password) {
    try {
      return supabase.auth.signInWithPassword(email: email, password: password);
    } on AuthException catch (e) {
      throw const AuthException("Invalid email or password");
    }
  }

  Future<AuthResponse> signup(String email, String password) {
    try {
      return supabase.auth.signUp(email: email, password: password);
    } on AuthException catch (e) {
      throw const AuthException(
          "Signup failed, please try again later"); //TODO: create own exception to decouple from supabase
    }
  }

  Future<void> signOut() async {
    try {
      await supabase.auth.signOut();
      await GoogleSignIn().signOut();
    } catch (e) {
      // handle error
    }
  }

  Future<AuthResponse> googleLogin() async {
    //use native google sign in if on android, otherwise use appauth
    //native doesnt work on ios because it doesnt return a nonce
    try {
      if (Platform.isAndroid) {
        return _googleSignInUsingFlutterPackage();
      } else if (Platform.isIOS) {
        return _googleSignInUsingAppAuth();
      } else {
        throw UnsupportedError('Unsupported platform');
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  String _generateRandomString() {
    final random = Random.secure();
    return base64Url.encode(List<int>.generate(16, (_) => random.nextInt(256)));
  }

  Future<AuthResponse> _googleSignInUsingFlutterPackage() async {
    //only works on android, ios version of google_sign_in includes a nonce in the idToken but does not allow access to the raw nonce value
    //see https://github.com/supabase/supabase-flutter/issues/625
    if (!Platform.isAndroid) {
      throw UnsupportedError('Unsupported platform');
    }

    //first signs user out, otherwise the popup never shows
    await GoogleSignIn().signOut();

    //pulls a web clientId  from res/values/strings.xml and uses it as a server id
    final googleSignIn = GoogleSignIn(
      scopes: ['email', "https://www.googleapis.com/auth/userinfo.profile"],
    );

    final googleUser = await googleSignIn.signIn();

    if (googleUser == null) {
      throw ("The google user is null");
    }

    final googleAuth = await googleUser.authentication;

    if (googleAuth == null) {
      throw ("The google auth is null");
    }

    return supabase.auth.signInWithIdToken(
      provider: Provider.google,
      idToken: googleAuth.idToken!,
    );
  }

  Future<AuthResponse> _googleSignInUsingAppAuth() async {
    //works on both android and IOS but pushes user to browser to sign in.
    // Just a random string
    final rawNonce = _generateRandomString();
    final hashedNonce = sha256.convert(utf8.encode(rawNonce)).toString();

    /// google clouid client id from cloud console/firebase.
    final String clientId;
    if (Platform.isIOS) {
      clientId = OAuthConfig().iosClientId;
    } else if (Platform.isAndroid) {
      clientId = OAuthConfig().androidClientId;
    } else {
      throw UnsupportedError('Unsupported platform');
    }

    /// reverse DNS form of the client ID + `:/` is set as the redirect URL
    final redirectUrl = '${clientId.split('.').reversed.join('.')}:/';

    /// Fixed value for google login
    const discoveryUrl =
        'https://accounts.google.com/.well-known/openid-configuration';

    const appAuth = FlutterAppAuth();

    // authorize the user by opening the concent page
    final result = await appAuth.authorize(
      AuthorizationRequest(
        clientId,
        redirectUrl,
        discoveryUrl: discoveryUrl,
        nonce: hashedNonce,
        scopes: [
          'openid',
          'email',
        ],
      ),
    );

    if (result == null) {
      throw 'No result';
    }

    // Request the access and id token to google
    final tokenResult = await appAuth.token(
      TokenRequest(
        clientId,
        redirectUrl,
        authorizationCode: result.authorizationCode,
        discoveryUrl: discoveryUrl,
        codeVerifier: result.codeVerifier,
        nonce: result.nonce,
        scopes: [
          'openid',
          'email',
        ],
      ),
    );

    final idToken = tokenResult?.idToken;

    if (idToken == null) {
      throw 'No idToken';
    }

    return supabase.auth.signInWithIdToken(
      provider: Provider.google,
      idToken: idToken,
      nonce: rawNonce,
    );
  }
}

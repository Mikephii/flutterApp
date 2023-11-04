import 'package:buddybrew/services/auth_service/supabase/supa_auth.dart';
import 'package:buddybrew/presentation/shared/buddybrew_logo.dart';
import 'package:buddybrew/presentation/screens/login/email_login_form.dart';
import 'package:buddybrew/presentation/screens/login/email_signup_form.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //List view prevent keyboard from covering widgets
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.08),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AuthScreenHeader(),
              AnimatedSize(
                  duration: Duration(milliseconds: 120),
                  child: EmailSigninSignup()),
              //or divider with text
              Container(
                margin: EdgeInsets.only(top: 20, bottom: 20),
                child: Row(
                  children: [
                    Expanded(
                        child: const Divider(
                      height: 1,
                    )),
                    Container(
                      margin: const EdgeInsets.only(left: 8, right: 8),
                      child: const Text("or"),
                    ),
                    Expanded(
                        child: const Divider(
                      height: 1,
                    )),
                  ],
                ),
              ),

              LoginButton(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  icon: FontAwesomeIcons.google,
                  text: "Continue with Google",
                  loginMethod: SupaAuthService().signInWithGoogle),
              //will become apple login button
              LoginButton(
                  color: Colors.black,
                  icon: FontAwesomeIcons.apple,
                  text: "Continue with Apple",
                  loginMethod: SupaAuthService().signInWithGoogle),
            ],
          ),
        ),
      ),
    );
  }
}

class AuthScreenHeader extends StatelessWidget {
  const AuthScreenHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 60, bottom: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            BuddybrewLogo(size: 50),
            Text("Buddybrew", style: Theme.of(context).textTheme.displayMedium)
          ],
        ));
  }
}

class LoginButton extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String text;
  final Function loginMethod;

  const LoginButton(
      {super.key,
      required this.color,
      required this.icon,
      required this.text,
      required this.loginMethod});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: FilledButton.icon(
        label: Text(text),
        onPressed: () => loginMethod(),
        icon: Icon(icon, color: Colors.white, size: 20),
        style: FilledButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.all(10),
        ),
      ),
    );
  }
}

class EmailSigninSignup extends StatefulWidget {
  const EmailSigninSignup({super.key});

  @override
  State<EmailSigninSignup> createState() => _EmailSigninSignupState();
}

class _EmailSigninSignupState extends State<EmailSigninSignup> {
  bool _isLogin = false;

  void toggleSignupSignin() {
    setState(() {
      _isLogin = !_isLogin;
    });
  }

  //animated switcher

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
        duration: Duration(milliseconds: 500),
        child: _isLogin
            ? LoginForm(toggleSignupSignin: toggleSignupSignin)
            : SignupForm(toggleSignupSignin: toggleSignupSignin));
  }
}

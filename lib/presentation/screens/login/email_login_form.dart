import 'package:buddybrew/services/supa_auth.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginForm extends StatefulWidget {
  final Function toggleSignupSignin;
  const LoginForm({super.key, required this.toggleSignupSignin});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoadingSignIn = false;
  final _formkey = GlobalKey<FormState>();
  String? _formErrorMessage;
  bool _autoValidate = false;

  bool _obscurePasswordText = true;

  _loginMethod() async {
    _formErrorMessage = null; //reset error message
    if (!_formkey.currentState!.validate()) {
      setState(() {
        _autoValidate = true;
      });
      return;
    }

    setState(() {
      _isLoadingSignIn = true;
    });
    try {
      await SupaAuthService().signInWithEmailPassword(
          _emailController.text, _passwordController.text);
    } on AuthException catch (e) {
      //rethrowing exceptions in AuthService to prevent sharing server info with client
      //safe to set message here because it is a custom exception
      setState(() {
        _formErrorMessage = e.message;
      });
    }
    setState(() {
      _isLoadingSignIn = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(0),
      child: Form(
        autovalidateMode: _autoValidate
            ? AutovalidateMode.onUserInteraction
            : AutovalidateMode.disabled,
        key: _formkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //title
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Text(
                "Log in to your account using email",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Container(
              height: 78, //height of text field + error message
              margin: EdgeInsets.only(bottom: 8),
              child: TextFormField(
                decoration: const InputDecoration(
                    isDense: true,
                    prefixIcon: Icon(Icons.email),
                    hintText: "Email"),
                controller: _emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email address';
                  }
                  if (!value.contains('@')) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
            ),
            Container(
              height: 78, //height of text field + error message
              margin: EdgeInsets.only(bottom: 8),

              child: TextFormField(
                obscureText: _obscurePasswordText,
                decoration: InputDecoration(
                    isDense: true,
                    hintText: "Password",
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscurePasswordText = !_obscurePasswordText;
                        });
                      },
                      icon: Icon(_obscurePasswordText
                          ? Icons.visibility_off
                          : Icons.visibility),
                    )),
                controller: _passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
            ),
            if (_formErrorMessage != null)
              Container(
                margin: EdgeInsets.only(bottom: 5),
                child: Text(
                  _formErrorMessage ?? "",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            FilledButton(
              onPressed: _loginMethod,
              child: _isLoadingSignIn
                  ? Container(
                      width: 24,
                      height: 24,
                      padding: const EdgeInsets.all(2.0),
                      child: const CircularProgressIndicator(
                        strokeWidth: 3,
                      ),
                    )
                  : const Text("Log in"),
            ),
            Row(
              children: [
                const Text("Don't have an account?"),
                TextButton(
                  onPressed: () {
                    widget.toggleSignupSignin();
                  },
                  child: const Text("Sign up"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

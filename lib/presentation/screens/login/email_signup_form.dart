import 'dart:convert';
import 'dart:developer';

import 'package:buddybrew/services/auth_service/supabase/supa_auth.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignupForm extends StatefulWidget {
  final Function toggleSignupSignin;
  const SignupForm({super.key, required this.toggleSignupSignin});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoadingSignup = false;
  final _formkey = GlobalKey<FormState>();
  String? _formErrorMessage;
  bool _autoValidate = false;

  bool _obscurePasswordText = true;
  bool _obscureConfirmPasswordText = true;

  _loginMethod() async {
    _formErrorMessage = null; //reset error message
    if (!_formkey.currentState!.validate()) {
      setState(() {
        _autoValidate = true;
      });
      return;
    }

    setState(() {
      _isLoadingSignup = true;
    });
    try {
      await SupaAuthService().signUpWithEmailPassword(
          _emailController.text, _passwordController.text);
    } on AuthException catch (e) {
      setState(() {
        _formErrorMessage = e.message;
      });
      print(e.toString());
    } catch (e) {
      print("other");
      print(jsonEncode(e));
      setState(() {
        _formErrorMessage = e.toString();
      });
    }
    setState(() {
      _isLoadingSignup = false;
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
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Text(
                "Create an account using email",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Container(
              height: 78, //height of text field + error message
              margin: EdgeInsets.only(bottom: 8),
              child: TextFormField(
                decoration: const InputDecoration(
                    counterText: " ",
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
                  if (!value.contains(RegExp(r'[A-Z]'))) {
                    return 'Password must contain at least one uppercase letter';
                  }
                  if (!value.contains(RegExp(r'[a-z]'))) {
                    return 'Password must contain at least one lowercase letter';
                  }
                  if (!value.contains(RegExp(r'[0-9]'))) {
                    return 'Password must contain at least one number';
                  }
                  if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                    return 'Password must contain at least one special character';
                  }
                  return null;
                },
              ),
            ),
            Container(
              height: 78, //height of text field + error message
              margin: EdgeInsets.only(bottom: 8),
              child: TextFormField(
                obscureText: _obscureConfirmPasswordText,
                decoration: InputDecoration(
                    isDense: true,
                    hintText: "Confirm Password",
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscureConfirmPasswordText =
                              !_obscureConfirmPasswordText;
                        });
                      },
                      icon: Icon(_obscureConfirmPasswordText
                          ? Icons.visibility_off
                          : Icons.visibility),
                    )),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  }
                  if (value != _passwordController.text) {
                    return 'Passwords must match';
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
              child: _isLoadingSignup
                  ? Container(
                      width: 24,
                      height: 24,
                      padding: const EdgeInsets.all(2.0),
                      child: const CircularProgressIndicator(
                        strokeWidth: 3,
                      ),
                    )
                  : const Text("Create Account"),
            ),
            Row(
              children: [
                const Text("Already have an account?"),
                TextButton(
                  onPressed: () {
                    widget.toggleSignupSignin();
                  },
                  child: const Text("Log in"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

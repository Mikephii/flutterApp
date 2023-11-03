import 'package:flutter/material.dart';
import 'package:buddybrew/presentation/shared/bottom_nav.dart';
import 'package:go_router/go_router.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About"),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () => GoRouter.of(context).go("/"),
            child: const Text("route to home")),
      ),
    );
  }
}

import "package:carpooling_app/pages/login_page.dart";
import "package:carpooling_app/pages/register_page.dart";
import "package:flutter/material.dart";

class Decider extends StatefulWidget {
  const Decider({super.key});

  @override
  State<Decider> createState() => _DeciderState();
}

class _DeciderState extends State<Decider> {
  bool showLoginPage = true;

  void togglePage() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(ontap: togglePage);
    } else {
      return RegisterPage(ontap: togglePage);
    }
  }
}

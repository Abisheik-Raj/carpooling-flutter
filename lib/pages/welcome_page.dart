import "package:carpooling_app/resources/color.dart";
import "package:flutter/material.dart";

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: blueColor,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, "/register_page");
          },
          child: const Icon(
            Icons.arrow_forward_ios,
            color: blueColor,
          ),
        ),
        body: const Center(
            child: Text(
          "LiftLoop",
          style: TextStyle(
              color: Colors.white, fontFamily: "PoppinsBold", fontSize: 40),
        )));
  }
}

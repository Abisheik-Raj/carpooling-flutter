import "package:carpooling_app/resources/color.dart";
import "package:flutter/material.dart";

class ButtonComponent extends StatelessWidget {
  final String text;
  const ButtonComponent({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      width: double.infinity,
      decoration: BoxDecoration(
        color: blueColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
              fontFamily: "PoppinsBold", fontSize: 15, color: Colors.white),
        ),
      ),
    );
  }
}

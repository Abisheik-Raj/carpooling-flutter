import "package:carpooling_app/resources/color.dart";
import "package:flutter/material.dart";

class TextFieldComponent extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool obscure;
  const TextFieldComponent({
    super.key,
    required this.hintText,
    required this.controller,
    required this.obscure,
  });

  @override
  Widget build(BuildContext context) {
    const border = UnderlineInputBorder(
        borderSide: BorderSide(color: Color.fromRGBO(221, 220, 221, 1)));

    const focusedBorder =
        UnderlineInputBorder(borderSide: BorderSide(color: blueColor));
    return TextField(
      cursorColor: blueColor,
      controller: controller,
      obscureText: obscure,
      style: const TextStyle(color: blueColor, fontFamily: "PoppinsRegular"),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(fontFamily: "PoppinsRegular"),
        border: focusedBorder,
        enabledBorder: border,
        focusedBorder: focusedBorder,
      ),
    );
  }
}

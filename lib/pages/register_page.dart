import "package:carpooling_app/components/button_component.dart";
import "package:carpooling_app/components/textfield_component.dart";
import "package:carpooling_app/services/auth_service.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

class RegisterPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final void Function()? ontap;

  RegisterPage({super.key, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Join LiftLoop",
              style: TextStyle(fontFamily: "PoppinsBold", fontSize: 35),
            ),
            const SizedBox(
              height: 30,
            ),
            TextFieldComponent(
              hintText: "Full name",
              controller: usernameController,
              obscure: false,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFieldComponent(
              hintText: "Email",
              controller: emailController,
              obscure: false,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFieldComponent(
                hintText: "Password",
                controller: passwordController,
                obscure: true),
            const SizedBox(
              height: 50,
            ),
            GestureDetector(
              onTap: () {
                final authService =
                    Provider.of<AuthService>(context, listen: false);
                try {
                  authService.register(usernameController.text,
                      emailController.text, passwordController.text);
                } catch (e) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(e.toString())));
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(e.toString())));
                }
              },
              child: const ButtonComponent(
                text: "Register",
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have an account? ",
                  style: TextStyle(fontFamily: "PoppinsRegular", fontSize: 13),
                ),
                GestureDetector(
                  onTap: ontap,
                  child: const Text(
                    "Login",
                    style: TextStyle(fontFamily: "PoppinsBold", fontSize: 13),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

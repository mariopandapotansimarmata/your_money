import 'package:flutter/material.dart';
import 'package:your_money_flutter/auth/firebaseauth.dart';
import 'package:your_money_flutter/repository/utils/overlay_utils.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailController = TextEditingController(text: "");
  TextEditingController passwordController = TextEditingController(text: "");

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.grey[50],
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: TextField(
              controller: emailController,
              decoration: const InputDecoration(
                  border: InputBorder.none, hintText: "Email"),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.grey[50],
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                  border: InputBorder.none, hintText: "Password"),
            ),
          ),
        ),
        Container(
            margin: const EdgeInsets.symmetric(vertical: 25),
            constraints: const BoxConstraints(maxWidth: 500),
            height: 40,
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
                onPressed: () async {
                  OverlayUtils.showOverlay(context, "Signing In",
                      action: () async {
                    String? result = await Auth.logInByEmailPassword(
                        emailController.text, passwordController.text);
                    print(result);
                    if (result != "success") {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(result!),
                        ),
                      );
                    }
                  });
                },
                child: const Text("Sign In"))),
      ],
    );
  }

  void showNotification(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.orange.shade900,
      content: Text(message.toString()),
    ));
  }
}

import 'package:flutter/material.dart';
import 'package:your_money_flutter/auth/firebaseauth.dart';

import '../assets/material_properties.dart';
import '../repository/utils/overlay_utils.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController displayName = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool isVisible = false;
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    displayName.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
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

        Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
              color: Colors.grey[50],
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: TextField(
              controller: displayName,
              decoration: const InputDecoration(
                  border: InputBorder.none, hintText: "Name"),
            ),
          ),
        ),

        //-- password Texrfield
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
              color: Colors.grey[50],
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: EdgeInsets.only(left: 18.0),
            child: TextField(
              controller: passwordController,
              obscureText: isVisible,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(top: 12),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          isVisible = !isVisible;
                        });
                      },
                      child: isVisible
                          ? Icon(Icons.visibility)
                          : Icon(Icons.visibility_off),
                    ),
                  ),
                  border: InputBorder.none,
                  hintText: "Password"),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
              color: Colors.grey[50],
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: TextField(
              controller: confirmPasswordController,
              obscureText: isVisible,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(top: 12),
                  suffixIcon: Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          isVisible = !isVisible;
                        });
                      },
                      child: isVisible
                          ? Icon(Icons.visibility)
                          : Icon(Icons.visibility_off),
                    ),
                  ),
                  border: InputBorder.none,
                  hintText: "Confirm Password"),
            ),
          ),
        ),

        //--sign in button
        Container(
            margin: const EdgeInsets.symmetric(vertical: 25),
            constraints: const BoxConstraints(maxWidth: 500),
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: MaterialProperties.primaryBlueColor,
                ),
                onPressed: () async {
                  if (passwordController.text ==
                      confirmPasswordController.text) {
                    OverlayUtils.showOverlay(context, "Signin Up",
                        action: () async {
                      bool success = await Auth.createUser(emailController.text,
                          passwordController.text, displayName.text);
                      if (!success) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(
                                "Failed to create user, email might be used"),
                          ),
                        );
                      }
                    });
                  }
                },
                child: Text(
                  "Sign Up",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: MaterialProperties.whiteTextColor),
                ))),
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

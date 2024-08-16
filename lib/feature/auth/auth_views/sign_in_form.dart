import 'package:flutter/material.dart';
import 'package:your_money_flutter/assets/material_properties.dart';
import 'package:your_money_flutter/feature/auth/auth_view_model/auth_view_model.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthViewModel _authViewModel = AuthViewModel();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isVisible = true;

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
              obscureText: isVisible,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(top: 12),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          isVisible = !isVisible;
                        });
                      },
                      child: isVisible
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility),
                    ),
                  ),
                  border: InputBorder.none,
                  hintText: "Password"),
            ),
          ),
        ),
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
                  _authViewModel.signIn(
                      context, emailController, passwordController);
                },
                child: Text(
                  "Sign In",
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

import 'package:flutter/material.dart';
import 'package:your_money_flutter/feature/auth/auth_views/sign_up_form.dart';
import 'package:your_money_flutter/feature/auth/auth_views/sign_in_form.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  TextEditingController emailController = TextEditingController(text: "");
  TextEditingController passwordController = TextEditingController(text: "");

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  var loginState = [const SignIn(), const SignUp()];
  int screenState = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Container(
              constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height * 0.5,
                  maxHeight: MediaQuery.of(context).size.height * 0.75),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //-- Logo
                  const Column(
                    children: [
                      Icon(
                        Icons.wallet_outlined,
                        size: 150,
                      ),
                      Text(
                        "Your Money",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 34),
                      ),
                      SizedBox(
                        height: 80,
                      ),
                    ],
                  ),

                  loginState[screenState],
                  screenState == 0
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have account? "),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  screenState = 1;
                                });
                              },
                              child: const Text(
                                "Sign Up",
                                style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Back to "),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  screenState = 0;
                                });
                              },
                              child: const Text(
                                "Sign In",
                                style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showNotification(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.orange.shade900,
      content: Text(message.toString()),
    ));
  }
}

import 'package:flutter/material.dart';

import '../../../repository/auth_repository.dart';
import '../../../utils/overlay_utils.dart';

class AuthViewModel {
  final AuthRepository _authRepository = AuthRepository();

  void signIn(BuildContext context, TextEditingController emailController,
      TextEditingController passwordController) {
    OverlayUtils.showOverlay(context, "Signing In", action: () async {
      String? result = await _authRepository.logInByEmailPassword(
          emailController.text, passwordController.text);

      if (result != "success") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(result!),
          ),
        );
      }
    });
  }

  void signUp(
      BuildContext context,
      TextEditingController emailController,
      TextEditingController passwordController,
      TextEditingController displayName,
      TextEditingController confirmPasswordController) {
    if (passwordController.text == confirmPasswordController.text) {
      OverlayUtils.showOverlay(context, "Signin Up", action: () async {
        bool success = await _authRepository.createUser(
            emailController.text, passwordController.text, displayName.text);

        if (!success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.red,
              content: Text("Failed to create user, email might be used"),
            ),
          );
        }
      });
    }
  }
}

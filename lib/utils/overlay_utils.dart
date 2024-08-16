import 'package:flutter/material.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import 'package:your_money_flutter/assets/material_properties.dart';

class OverlayUtils {
  static void showOverlay(BuildContext context, String text,
      {required Function action}) async {
    OverlayLoadingProgress.start(
      context,
      widget: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                color: MaterialProperties.primaryBlueColor,
              ),
              const SizedBox(
                  height: 20), // Add some spacing between the loader and text
              Text(
                text,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );

    await Future.delayed(const Duration(milliseconds: 600));

    OverlayLoadingProgress.stop();

    action();
  }
}

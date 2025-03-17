import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingIndicator {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return PopScope(
          canPop: false,
          child: Dialog(
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: Center(
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white, // Background color
                  borderRadius: BorderRadius.circular(10), // Rounded corners
                ),
                child: const Center(
                  child: CupertinoActivityIndicator(
                    radius: 15,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static void dismiss(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }
}

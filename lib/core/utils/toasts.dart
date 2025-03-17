import 'package:toastification/toastification.dart';
import 'package:flutter/material.dart';

class Toasts {
  Toasts._();
  static void showSuccessToast(String message) {
    Toastification().show(
      title: Text(message),
      type: ToastificationType.success,
      style: ToastificationStyle.flat,
      autoCloseDuration: Duration(seconds: 2),
      showProgressBar: false,
    );
  }

  static void showErrorToast(String message) {
    Toastification().show(
      title: Text(message),
      type: ToastificationType.error,
      style: ToastificationStyle.flat,
      autoCloseDuration: Duration(seconds: 2),
      showProgressBar: false,
    );
  }

  static void showInfoToast(String message) {
    Toastification().show(
      title: Text(message),
      type: ToastificationType.info,
      style: ToastificationStyle.flat,
      autoCloseDuration: Duration(seconds: 2),
      showProgressBar: false,
    );
  }

  static void showWarningToast(String message) {
    Toastification().show(
      title: Text(message),
      type: ToastificationType.warning,
      style: ToastificationStyle.flat,
      autoCloseDuration: Duration(seconds: 2),
      showProgressBar: false,
    );
  }
}

// custom_snackbars.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSuccessSnackbar(String message) {
  Get.snackbar(
    "تم بنجاح",
    message,
    backgroundColor: Colors.green[100],
    colorText: Colors.black,
    icon: const Icon(Icons.check_circle, color: Colors.green),
    snackPosition: SnackPosition.TOP,
  );
}

void showWarningSnackbar(String message) {
  Get.snackbar(
    "تنبيه",
    message,
    backgroundColor: Colors.yellow[100],
    colorText: Colors.black,
    icon: const Icon(Icons.warning, color: Colors.orange),
    snackPosition: SnackPosition.TOP,
  );
}

void showErrorSnackbar(String message) {
  Get.snackbar(
    "خطأ",
    message,
    backgroundColor: Colors.red[100],
    colorText: Colors.black,
    icon: const Icon(Icons.error, color: Colors.red),
    snackPosition: SnackPosition.TOP,
  );
}

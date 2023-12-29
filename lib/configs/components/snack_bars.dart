
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

void showSuccessSnackBar(BuildContext context) {
  toastification.show(
    context: context,
    type: ToastificationType.success,
    style: ToastificationStyle.flatColored,
    title: 'خوش اومدی',
    description: 'به حساب‌کاربری وارد شدید',
    icon: const Icon(Icons.task_alt_outlined),
    alignment: Alignment.bottomCenter,
    autoCloseDuration: const Duration(seconds: 4),
    boxShadow: lowModeShadow,
    
    direction: TextDirection.rtl,
    dragToClose: true,
  );
}

void showFailedSnackBar(BuildContext context) {
  toastification.show(
    context: context,
    type: ToastificationType.error,
    style: ToastificationStyle.flatColored,
    title: 'یه مشکلی پیش اومده',
    description: 'اطلاعات رو دوباره بررسی کنید',
    alignment: Alignment.bottomCenter,
    autoCloseDuration: const Duration(seconds: 4),
    boxShadow: lowModeShadow,
    direction: TextDirection.rtl,
    dragToClose: true,
  );
}

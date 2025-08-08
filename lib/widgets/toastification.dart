import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

import '../core/theme/colors.dart';

class AppToastsWidget {
  // danger, info, success, and warning toastification methods

  static void dangerToastification(BuildContext context, String notificationMsg) {
    toastification.show(
      context: context,
      icon: Icon(BootstrapIcons.exclamation_circle, color: kIconLightColor),
      title: Text(notificationMsg, style: TextStyle(color: kTextLightColor)),
      type: ToastificationType.error,
      style: ToastificationStyle.fillColored,
      alignment: Alignment.bottomCenter,
      showProgressBar: true,
      autoCloseDuration: const Duration(seconds: 7),
      backgroundColor: kDangerColor,
      dragToClose: true,
      pauseOnHover: true,
    );
  }


  static void infoToastification(BuildContext context, String notificationMsg) {
    toastification.show(
      context: context,
      icon: Icon(BootstrapIcons.info_circle, color: kIconLightColor),
      title: Text(notificationMsg, style: TextStyle(color: kTextLightColor)),
      type: ToastificationType.info,
      style: ToastificationStyle.fillColored,
      alignment: Alignment.bottomCenter,
      showProgressBar: true,
      autoCloseDuration: const Duration(seconds: 7),
      backgroundColor: kInfoColor,
      dragToClose: true,
      pauseOnHover: true,
    );
  }

  static void successToastification(BuildContext context, String notificationMsg) {
    toastification.show(
      context: context,
      icon: Icon(BootstrapIcons.check_circle, color: kIconLightColor),
      title: Text(notificationMsg, style: TextStyle(color: kTextLightColor)),
      type: ToastificationType.success,
      style: ToastificationStyle.fillColored,
      alignment: Alignment.bottomCenter,
      showProgressBar: true,
      autoCloseDuration: const Duration(seconds: 7),
      backgroundColor: kSuccessColor,
      dragToClose: true,
      pauseOnHover: true,
    );
  }
  static void warningToastification(BuildContext context, String notificationMsg) {
    toastification.show(
      context: context,
      icon: Icon(BootstrapIcons.exclamation_triangle, color: kIconLightColor),
      title: Text(notificationMsg, style: TextStyle(color: kTextLightColor)),
      type: ToastificationType.warning,
      style: ToastificationStyle.fillColored,
      alignment: Alignment.bottomCenter,
      showProgressBar: true,
      autoCloseDuration: const Duration(seconds: 7),
      backgroundColor: kWarningColor,
      dragToClose: true,
      pauseOnHover: true,
    );
  }
}

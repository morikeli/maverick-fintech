import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../core/theme/colors.dart';

class LoadingWidget {
  static Widget newtonCradleLarge() {
    return LoadingAnimationWidget.newtonCradle(color: kPrimaryColor, size: 280.0);
  }

  static Widget newtonCradleMedium() {
    return LoadingAnimationWidget.newtonCradle(color: kPrimaryColor, size: 200.0);
  }

  static Widget newtonCradleMediumSmall() {
    return LoadingAnimationWidget.newtonCradle(color: kPrimaryColor, size: 160.0);
  }

  static Widget newtonCradleSmall() {
    return LoadingAnimationWidget.newtonCradle(color: kPrimaryColor, size: 100.0);
  }

  static Widget newtonCradleExtraSmall() {
    return LoadingAnimationWidget.newtonCradle(color: kPrimaryColor, size: 60.0);
  }

}

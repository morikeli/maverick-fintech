import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/pin_controller.dart';
import '../../../../widgets/loading_widget.dart';
import '../pin_setup_screen.dart';
import 'pin_prompt_form.dart';

class PINScreenBody extends StatelessWidget {
  const PINScreenBody({super.key, required this.pinController});

  final PinController pinController;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (pinController.isLoading.value) {
        return Scaffold(
          body: Center(child: LoadingWidget.newtonCradleMedium()),
        );
      }

      // If no PIN set, go to PIN setup screen
      if (!pinController.isPinSet.value) {
        Future.microtask(() => Get.offAll(() => PinSetupScreen()));
        return const SizedBox.shrink();
      }

      return PINPromptForm(controller: pinController);
    });
  }
}

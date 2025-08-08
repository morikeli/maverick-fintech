import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:maverick_app/controllers/theme_controller.dart';
import 'package:maverick_app/routes.dart';
import 'package:maverick_app/widgets/homescreen.dart';
import 'package:toastification/toastification.dart';

import 'core/helpers/firebase_options.dart';
import 'core/theme/theme.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MaverickApp());

  // whenever your initialization is completed, remove the splash screen:
  FlutterNativeSplash.remove();
}

class MaverickApp extends StatelessWidget {
  MaverickApp({super.key});
  final ThemeController themeController = Get.put(ThemeController());

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ToastificationWrapper(
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Maverick',
          darkTheme: MaverickAppTheme.darkTheme,
          theme: MaverickAppTheme.lightTheme,
          themeMode: themeController.themeMode.value,
          home: HomeScreen(),
          initialRoute: '/onboarding-screen',
          routes: routes,
        ),
      );
    });
  }
}

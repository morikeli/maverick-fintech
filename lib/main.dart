import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:maverick_app/routes.dart';

import 'core/theme/theme.dart';
import 'features/auth/login/login_screen.dart';


void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MaverickApp());

  // whenever your initialization is completed, remove the splash screen:
  FlutterNativeSplash.remove();
}

class MaverickApp extends StatelessWidget {
  const MaverickApp({super.key});

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

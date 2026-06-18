import 'package:echallan/screens/auth_screen/forget_password.dart';
import 'package:echallan/screens/auth_screen/login_screen.dart';
import 'package:echallan/screens/users_screens/camra_capture_scerren.dart';
import 'package:echallan/utils/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'screens/onboarding_screen/splash_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Get.putAsync(() => AuthService().init());
  runApp(DevicePreview(
    enabled: false,
    builder: (context) => const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Sizer',
          theme: ThemeData.light(),
          home: SplashScreen(), // Replace with your initial screen
        );
      },
    );
  }
}

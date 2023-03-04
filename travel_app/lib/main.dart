import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:travel_app/firebase_options.dart';
import 'package:travel_app/registration.dart';
import 'package:travel_app/utils/MStyles.dart';
import 'package:travel_app/utils/constants.dart';
import 'package:travel_app/views/login_screen_v3.dart';
import 'package:travel_app/views/sign_up.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context , child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Travel App',
          theme: ThemeData(
            // colorScheme: ColorScheme.dark(primary: MStyles.pColor),
            // colorScheme: ColorScheme.light(primary: MStyles.greenColor),
            colorScheme: ColorScheme.light(primary: MStyles.pColor),
            // scaffoldBackgroundColor: const Color(0xff000512),
            // scaffoldBackgroundColor: MStyles.bgv2.withOpacity(0.10),
            scaffoldBackgroundColor: Colors.white
          ),
          // home: const BasicIntro(),
          // home: const LoginScreen(),
          home: LoginScreenV3(),
        );
      },

    );
  }
}

//start working on login without anims
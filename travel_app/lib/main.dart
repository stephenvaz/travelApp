import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:travel_app/firebase_options.dart';
import 'package:travel_app/registration.dart';
import 'package:travel_app/utils/MStyles.dart';
import 'package:travel_app/utils/constants.dart';
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
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // title: 'Travelio',
      title: appName,
      theme: ThemeData(
        // colorScheme: ColorScheme.dark(primary: MStyles.pColor),
        colorScheme: ColorScheme.dark(primary: MStyles.greenColor),
        // scaffoldBackgroundColor: const Color(0xff000512),
      ),
      // home: const Login(),
      home: const SignUp(),
    );
  }
}

//start working on login without anims
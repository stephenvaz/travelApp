import 'package:flutter/material.dart';
import 'package:get/get.dart';

String email = '';
String password = '';
final loginKey = GlobalKey<FormState>();
RxBool isLoading = false.obs;

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Theme(
            data: ThemeData(
              // useMaterial3: true,
              inputDecorationTheme: const InputDecorationTheme(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            child: Form(
              key: loginKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Welcome Back!',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: TextFormField(
                      textCapitalization: TextCapitalization.none,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: 'Email',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                      validator: (value) {
                        if (value!.isEmpty ||
                            !RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9.]+$')
                                .hasMatch(value)) {
                          return 'Enter valid email id';
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) {
                        email = value;
                      },
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: TextFormField(
                      enableSuggestions: false,
                      style: const TextStyle(color: Colors.white),
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: 'Password',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                      validator: (value) {
                        if (value!.isEmpty || value.length < 6) {
                          return 'Password cannot be less than 6 characters';
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) => password = value,
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  Obx(() {
                    return AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        child: (!isLoading.value)
                            ? ElevatedButton(
                          onPressed: () async {
                            if (loginKey.currentState!.validate()) {
                              isLoading.value = true;
                              // bool status = await login(email, password);
                              // if (status) {
                              //   // check.fire();
                              //   Get.closeAllSnackbars();
                              //   Get.snackbar(
                              //     'Success',
                              //     'Logged In Successfully',
                              //     snackPosition: SnackPosition.TOP,
                              //     backgroundColor:
                              //         Colors.green.withOpacity(0.2),
                              //     colorText: Colors.white,
                              //   );
                              //   await Future.delayed(
                              //     const Duration(seconds: 2),
                              //   );
                              //   Get.offAll(
                              //     () => const Main(),
                              //     transition: Transition.fadeIn,
                              //   );
                              // } else {
                              //   error.fire();
                              //   Get.closeAllSnackbars();
                              //   Get.snackbar(
                              //     'Error',
                              //     'Invalid Credentials',
                              //     snackPosition: SnackPosition.TOP,
                              //     backgroundColor:
                              //         Colors.red.withOpacity(0.2),
                              //     colorText: Colors.white,
                              //   );
                              // }
                              // await Future.delayed(
                              //   const Duration(seconds: 2),
                              // );
                              isLoading.value = false;
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4ECCA3),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 80.0, vertical: 16.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          child: const Text('Log In'),
                        )
                            : const CircularProgressIndicator()
                    );
                  }),
                  const SizedBox(height: 20.0),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}

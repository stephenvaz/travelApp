import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:travel_app/controller/LoginController.dart';
import 'package:travel_app/utils/MStyles.dart';

class LoginScreenV3 extends StatelessWidget {
  LoginScreenV3({Key? key}) : super(key: key);

  LoginController loginController = LoginController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
            child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                Flexible(
                  child: Material(
                    elevation: 0,
                    clipBehavior: Clip.antiAlias,
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(200.h),
                          topLeft: Radius.circular(200.h)),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xff2e92da),
                          border: Border(bottom: BorderSide())),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Flexible(
                  child: Material(
                    elevation: 0,
                    clipBehavior: Clip.antiAlias,
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(225.h),
                          topLeft: Radius.circular(225.h)),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xff121827),
                          border: Border(bottom: BorderSide())),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    "assets/images/tr.png",
                    height: 175.w,
                  ),
                  SizedBox(height: 16.w),
                  TextField(
                    controller: loginController.email,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: "Email Address"),
                  ),
                  SizedBox(
                    height: 16.w,
                  ),
                  Obx(
                    () => TextField(
                        obscureText: loginController.isHidden.value,
                        controller: loginController.password,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            suffixIcon: GestureDetector(
                                onTap: () {
                                  loginController.toggleHidden();
                                },
                                child: Icon(loginController.isHidden.value
                                    ? Icons.visibility
                                    : Icons.visibility_off)),
                            labelText: "Password")),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 0.w, vertical: 30.w),
                    child: ElevatedButton(
                        onPressed: () => loginController.login(),
                        child: Text("LOGIN",
                            style: TextStyle(
                                fontSize: 18.w, fontWeight: FontWeight.w700)),
                        clipBehavior: Clip.antiAlias,
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size.fromHeight(50),
                            shape: BeveledRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.w))))),
                  ),
                  SizedBox(
                    height: 100.h,
                  )
                ],
              ),
            ),
            Obx(() => !loginController.isLoginLoading.value
                ? SizedBox()
                : TweenAnimationBuilder(
                    tween: Tween(begin: 0, end: 0.5),
                    duration: Duration(milliseconds: 500),
                    builder:
                        (BuildContext context, Object? value, Widget? child) {
                      return Positioned.fill(
                          child: Container(
                        color: MStyles.darkBgColor
                            .withOpacity(double.parse(value.toString())),
                        child: Center(child: CircularProgressIndicator()),
                      ));
                    },
                  ))
          ],
        )),
      ),
    );
  }
}

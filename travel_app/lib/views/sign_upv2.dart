import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app/api/api.dart';
import 'package:travel_app/controller/SignUpController.dart';
import 'package:travel_app/utils/MLocalStorage.dart';
import 'package:travel_app/utils/MStyles.dart';
import 'package:travel_app/utils/generic_util.dart';
import 'package:travel_app/views/create_profile.dart';

class SignUpV2 extends StatelessWidget {
  SignUpV2({Key? key}) : super(key: key);

  // SignUpContoller SignUpContoller = SignUpContoller();
  SignUpController createAccController = SignUpController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        body: Stack(
          // alignment: Alignment.bottomCenter,
          children: [
            Image.asset('assets/images/sign_up_banner.png'),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: ScreenUtil().screenHeight * 0.5 + 16,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(32)),
                    color: Colors.white),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        "Create Account",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 18.w,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    MTextField(
                      label: "Name",
                      mcont: createAccController.name,
                    ),
                    MTextField(
                      label: "Phone Number",
                      mcont: createAccController.phone,
                    ),
                    MTextField(
                      label: "Email",
                      mcont: createAccController.email,
                    ),
                    // MTextField(label: "Password", mcont: createAccController.password,),
                    Obx(
                      () => TextField(
                        obscureText: createAccController.isHidden.value,
                        controller: createAccController.password,
                        decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                              onTap: () {
                                createAccController.toggleHidden();
                              },
                              child: Icon(createAccController.isHidden.value
                                  ? Icons.visibility
                                  : Icons.visibility_off)),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: MStyles.pColor),
                          ),
                          label: Text("Password"),
                          filled: true,
                          fillColor: MStyles.pColor.withOpacity(0.25),
                        ),
                      ),
                    ),
                    Spacer(),
                    // SizedBox(height: 16,),
                    buildElevatedButton("CREATE", () async {
                      createAccController.toggleLoginLoading();
                      final res = await Api().createAccount(
                          createAccController.name.text,
                          createAccController.phone.text,
                          createAccController.email.text,
                          createAccController.password.text);
                      if (res["status"] == 1) {
                        GenericUtil.snackSuccess();
                        MLocalStorage().setEmailId(createAccController.email.text);
                        Get.off(() => CreateProfile());

                      } else {
                        GenericUtil.snackGeneric("Failed to create account", "Ensure all fields are filled properly");
                      }

                      //test
                      // Get.off(() => CreateProfile());
                      createAccController.toggleLoginLoading();
                    })
                  ],
                ),
              ),
            ),
            // Align(alignment: Alignment.bottomCenter, child: buildElevatedButton("SUBMIT", () {}))
            // Align(
            //   child: buildElevatedButton("SUBMIT", () {}),
            // )

            Obx(() => !createAccController.isLoginLoading.value
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
        ),
      ),
    );
  }
}

ElevatedButton buildElevatedButton(text, onPressed) {
  return ElevatedButton(
    onPressed: onPressed,
    child: Text(
      text,
      style: MStyles.primaryTextStyle
          .copyWith(fontWeight: FontWeight.w100, fontSize: 16.w),
    ),
    style: ElevatedButton.styleFrom(
        // backgroundColor: Color(0xFF81F886),
        // backgroundColor: Color(0xFF00E140),
        backgroundColor: MStyles.pColor,
        minimumSize: Size.fromHeight(50),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(100),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(100)))),
  );
}

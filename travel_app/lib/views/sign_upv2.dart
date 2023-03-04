import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app/components/custom_text_field.dart';
import 'package:travel_app/controller/SignUpController.dart';
import 'package:travel_app/utils/MStyles.dart';
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
                      mcont: createAccController.email,
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
                    buildElevatedButton("CREATE", () {
                      Get.off(() => CreateProfile());
                    })
                  ],
                ),
              ),
            ),
            // Align(alignment: Alignment.bottomCenter, child: buildElevatedButton("SUBMIT", () {}))
            // Align(
            //   child: buildElevatedButton("SUBMIT", () {}),
            // )
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



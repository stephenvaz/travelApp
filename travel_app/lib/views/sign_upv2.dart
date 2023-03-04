import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app/controller/SignUpController.dart';
import 'package:travel_app/utils/MStyles.dart';

class SignUpV2 extends StatelessWidget {
  SignUpV2({Key? key}) : super(key: key);

  // SignUpContoller SignUpContoller = SignUpContoller();
  SignUpController createAccController = SignUpController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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

class CreateProfile extends StatelessWidget {
  const CreateProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var onTap2 = () {
      showDatePicker(
        context: context,
        initialDate: DateTime(2005),
        firstDate: DateTime(1800),
        lastDate: DateTime(DateTime.now().year),
      );
    };
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(),
                  SizedBox(
                    // height: 72,
                    height: 36,
                  ),
                  CircleAvatar(
                    // child: Container(width: 100,height: 100,)
                    radius: 60,
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Text(
                    "About You",
                    style: MStyles.primaryTextStyle,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  MTextField(
                    label: "Bio",
                    mcont: TextEditingController(),
                    maxLen: 3,
                  ),
                  MTextField(label: "Interests", mcont: TextEditingController()),
                  // Row(
                  //   children: [Text(
                  //     "Type in your interests",
                  //     textAlign: TextAlign.start,
                  //     style: GoogleFonts.poppins(fontSize: 10,),
                  //   )],
                  // ),
                  MTextField(label: "City", mcont: TextEditingController()),
                  // GestureDetector(
                  //     onTap: () {
                  //       showDatePicker(context: context, initialDate: DateTime(2005), firstDate: DateTime(2005), lastDate: DateTime(2005));
                  //     },
                  //   // child: Text("test"),
                  //     child: IgnorePointer(
                  //       child: MTextField(
                  //           label: "Date Of Birth",
                  //           mcont: TextEditingController()),
                  //     )
                  // ),
                  MTextField(
                    suffixIcon: IconButton(
                      icon: Icon(Icons.calendar_month),
                      // onPressed: () {},
                      onPressed: onTap2,
                    ),
                    label: "Date Of Birth",
                    mcont: TextEditingController(),
                    onTap: onTap2,
                    readOnly: true,
                  ),
                  MTextField(
                      label: "Emergency Contact Number",
                      mcont: TextEditingController()),
                  Text(
                    "In case of emergencies like medical conditions or mishap, emergency contacts will be notified about your last location and your adventurer friends would be able to react out to them to tell about your condition",
                    style: GoogleFonts.poppins(fontSize: 10),
                  ),
                  // ConstrainedBox(constraints: BoxConstraints(minHeight: 0, maxHeight: double.maxFinite), child: Spacer()),
                  // Spacer(),
                  // SizedBox(height: 100,),
                  // buildElevatedButton("SUBMIT", () {}),
                  SizedBox(
                    height: 16,
                  ),
                  // MTextField(
                  //   label: "Bio",
                  //   mcont: TextEditingController(),
                  //   maxLen: 3,
                  // )
                ],
              ),
            ),
          ),
          Align(alignment: Alignment.bottomCenter, child: Padding(padding: EdgeInsets.all(16), child: buildElevatedButton("SUBMIT", () {})))
        ],
      ),
    ));
  }
}

class MTextField extends StatelessWidget {
  final maxLen;

  final onTap;

  final readOnly;

  final suffixIcon;

  const MTextField(
      {Key? key,
      required this.label,
      required this.mcont,
      this.maxLen,
      this.onTap,
      this.readOnly,
      this.suffixIcon})
      : super(key: key);

  final String label;
  final TextEditingController mcont;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        onTap: onTap,
        readOnly: readOnly ?? false,
        maxLines: maxLen ?? 1,
        controller: mcont,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: MStyles.pColor),
          ),
          label: Text(label),
          filled: true,
          fillColor: MStyles.pColor.withOpacity(0.25),
        ),
      ),
    );
  }
}

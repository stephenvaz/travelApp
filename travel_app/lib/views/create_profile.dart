import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app/components/custom_text_field.dart';
import 'package:travel_app/controller/CreateProfileController.dart';
import 'package:travel_app/utils/MStyles.dart';
import 'package:travel_app/views/sign_upv2.dart';

final createProfileController = CreateProfileController();

class CreateProfile extends StatelessWidget {
  const CreateProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var onTap2 = () async {
      final dt = await showDatePicker(
        context: context,
        initialDate: DateTime(2005),
        firstDate: DateTime(1800),
        lastDate: DateTime(DateTime.now().year),
      );

      createProfileController.dob.text = dt!.toIso8601String();
    };

    var listT= ["Male", "Female", "Non-binary"];

    var onTap2Gender = () async {
      showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text("Select Gender", style: MStyles.primaryTextStyle.copyWith(fontWeight: FontWeight.w100),),
              ),
              ...listT.map((e) => TextButton(onPressed: () {
                createProfileController.gender.text = e;
                Get.back();
              }, child: Text(e),))
            ]),
          );
        },
      );
    };
    return SafeArea(
        child: Scaffold(
      // resizeToAvoidBottomInset: false,
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
                  GestureDetector(
                    onTap: () {

                    },
                    child: CircleAvatar(
                      child: Icon(Icons.camera_alt, size: 40,),
                      // child: Container(width: 100,height: 100,)
                      radius: 60,
                    ),
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
                    mcont: createProfileController.bio,
                    maxLen: 3,
                  ),
                  MTextField(
                      label: "Interests",
                      mcont: createProfileController.interests),
                  // Row(
                  //   children: [Text(
                  //     "Type in your interests",
                  //     textAlign: TextAlign.start,
                  //     style: GoogleFonts.poppins(fontSize: 10,),
                  //   )],
                  // ),
                  MTextField(
                      label: "City", mcont: createProfileController.city),
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
                      icon: Icon(Icons.calendar_month), // onPressed: () {},
                      onPressed: onTap2,
                    ),
                    label: "Date Of Birth",
                    mcont: createProfileController.dob,
                    onTap: onTap2,
                    readOnly: true,
                  ),
                  MTextField(
                    suffixIcon: IconButton(
                      icon: Icon(Icons.arrow_drop_down), // onPressed: () {},
                      onPressed: onTap2Gender,
                    ),
                    label: "Gender",
                    mcont: createProfileController.gender,
                    onTap: onTap2Gender,
                    readOnly: true,
                  ),
                  MTextField(
                      label: "Emergency Contact Number",
                      mcont: createProfileController.emergencyNum),
                  Text(
                    "In case of emergencies like medical conditions or mishap, emergency contacts will be notified about your last location and your adventurer friends would be able to react out to them to tell about your condition",
                    style: GoogleFonts.poppins(fontSize: 10),
                  ),
                  // ConstrainedBox(constraints: BoxConstraints(minHeight: 0, maxHeight: double.maxFinite), child: Spacer()),
                  // Spacer(),
                  SizedBox(
                    height: 100,
                  ),
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
          Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                  padding: EdgeInsets.all(16),
                  child: buildElevatedButton("SUBMIT", () {
                    createProfileController.createProfile();
                  }))),
          Obx(() => !createProfileController.isLoginLoading.value
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
    ));
  }
}

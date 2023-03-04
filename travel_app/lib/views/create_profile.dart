import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app/components/custom_text_field.dart';
import 'package:travel_app/utils/MStyles.dart';
import 'package:travel_app/views/sign_upv2.dart';

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

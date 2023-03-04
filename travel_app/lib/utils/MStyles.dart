import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class MStyles {
  static final mTextStyle = TextStyle(fontSize: 18.w, fontWeight: FontWeight.w700);
  // static final pColor = Color(0xff2e92da);
  static final pColor = Color(0xFF00AAAC);
  static final darkGreenBgColor2 = Color(0xFF103928);
  static final greenColor = Color(0xFF43CD66);
  static final harshadGreenColor = Color(0xFF8BDF95);
  static final harshadGreenColor2 = Color(0xFF43A354);
  static final materialColor = Color(0xff121826);
  static final darkBgColor = Color(0xff010511);
  static final lightBgColor = Color(0xff070E1A);
  static final col3 = Color(0xcc2e92da);
  static final col4 = Color(0xff222257);
  static final col5 = Color(0xff000512);

  static final pColorWithTransparency  = Color(0xcc2e92da);

  static final primaryTextStyle = GoogleFonts.poppins(
    // fontFamily: 'Abraham',
      color: Colors.black,
      fontSize: 18.w,
      fontWeight: FontWeight.w500);

  // static ElevatedButton buildElevatedButton(Function func, String text) {
  //   return ElevatedButton(
  //       onPressed: () => func(),
  //       child: Text(text, style: TextStyle(fontSize: 18.w, fontWeight: FontWeight.w700)),
  //       clipBehavior: Clip.antiAlias,
  //       style: ElevatedButton.styleFrom(
  //           minimumSize: Size.fromHeight(50),
  //           shape: BeveledRectangleBorder(
  //               borderRadius:
  //               BorderRadius.all(Radius.circular(10.w))))
  //   );
  // }

}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:travel_app/api/api.dart';
import 'package:travel_app/components/mapssearch.dart';
import 'package:travel_app/utils/generic_util.dart';
import 'package:travel_app/views/sign_upv2.dart';

class HomeController extends GetxController {
  final currIndex = 0.obs;

  final pvC = PageController();

  void changeIndex(int p, {bool isFromPageView = false}) {
    currIndex.value = p;
    if(!isFromPageView) {
      // pvC.jumpToPage(p);
      pvC.animateTo(p*ScreenUtil().screenWidth, duration: Duration(milliseconds: 250), curve: Curves.decelerate, );
    }
    // pvC.jumpToPage(p);
    // pvC.jumpTo(currIndex.value.roundToDouble());//, duration: Duration(milliseconds: 250), curve: Curves.decelerate);
    // pvC.jumpTo(2);//, duration: Duration(milliseconds: 250), curve: Curves.decelerate);
    // pvC.jumpTo(2);//, duration: Duration(milliseconds: 250), curve: Curves.decelerate);
  }
}
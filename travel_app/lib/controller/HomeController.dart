import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:travel_app/api/api.dart';
import 'package:travel_app/components/mapssearch.dart';
import 'package:travel_app/utils/generic_util.dart';
import 'package:travel_app/views/sign_upv2.dart';

class HomeController extends GetxController {
  final currIndex = 0.obs;

  void changeIndex(int p) {
    currIndex.value = p;
  }
}
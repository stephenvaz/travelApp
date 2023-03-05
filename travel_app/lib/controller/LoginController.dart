import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:travel_app/api/api.dart';
import 'package:travel_app/utils/MLocalStorage.dart';
import 'package:travel_app/utils/generic_util.dart';

class LoginController extends GetxController {
  // final email = "".obs;
  final email = TextEditingController();
  final password = TextEditingController();

  final isHidden = true.obs;
  final isLoginLoading = false.obs;

  // LoginController() {
  //   setBaseUrl();
  // }

  void toggleHidden() {
    isHidden.value = !isHidden.value;
  }

  login() async {
    toggleLoginLoading();
    await setBaseUrl();
    final Map res = await Api().login(email.text, password.text);
    // final Map res = {'token': '123s'};
    // if (!res.containsKey('token')) {
    //   GenericUtil.snackGeneric("Failed", "Login Failed");
    // } else {
      if(res["status"] == 1)
      {GenericUtil.snackSuccess();
      // MLocalStorage().writeToken(res["token"]);
      MLocalStorage().setEmailId(email.text);
      print(MLocalStorage().getEmailId());}
      else {
        GenericUtil.snackGeneric("Failed", "Login Failed");
      }
    // }
    toggleLoginLoading();
  }

  void toggleLoginLoading() {
    isLoginLoading.value = !isLoginLoading.value;
  }

  Future<void> setBaseUrl() async {
    // DatabaseReference ref = FirebaseDatabase.instance.ref("base_url");
    // final player1ref = await ref.once();
    // MLocalStorage().setBaseUrl(player1ref.snapshot.value as String);
    final data = await FirebaseFirestore.instance
        .collection('travel_app')
        .doc('global_data')
        .get();
    // Api.BASE_URL = data['base_url'];
    Api.BASE_URL = 'https://2d15-2409-40c0-1006-a7b-6187-d5bb-34c3';
    // GeoPoint test = GeoPoint(123, 324);
  }
}

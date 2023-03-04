import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:travel_app/api/api.dart';

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

    toggleLoginLoading();
  }
  void toggleLoginLoading() {
    isLoginLoading.value = !isLoginLoading.value;
  }

  Future<void> setBaseUrl() async {
    // DatabaseReference ref = FirebaseDatabase.instance.ref("base_url");
    // final player1ref = await ref.once();
    // MLocalStorage().setBaseUrl(player1ref.snapshot.value as String);
    final data = await FirebaseFirestore.instance.collection('travel_app').doc('global_data').get();
    Api.BASE_URL = data['base_url'];
    Api.BASE_URL = data['base_url'];
    // GeoPoint test = GeoPoint(123, 324);

  }


}
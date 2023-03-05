import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:travel_app/api/api.dart';
import 'package:travel_app/utils/generic_util.dart';
import 'package:travel_app/views/sign_upv2.dart';

class CreateProfileController extends GetxController {
  // final email = "".obs;
  final bio = TextEditingController();
  final password = TextEditingController();
  final interests = TextEditingController();
  final city = TextEditingController();
  final dob = TextEditingController();
  final gender = TextEditingController();
  final emergencyNum = TextEditingController();

  final isHidden = true.obs;
  final isLoginLoading = false.obs;

  var imgString = "";

  // LoginController() {
  //   setBaseUrl();
  // }

  void toggleHidden() {
    isHidden.value = !isHidden.value;
  }

  createProfile() async {
    toggleLoginLoading();

    final res = await Api().createProfile(bio.text, interests.text.split(" "),
        city.text, dob.text, gender.text, emergencyNum.text.split(" "), imgString);
    if (res["status"] != 1) {
      GenericUtil.snackGeneric(
          "Failed to create profile", "Ensure all fields are filled properly");
    } else {
      GenericUtil.snackSuccess();

      //todo add home route here
      Get.off(() => SignUpV2());
    }
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
    Api.BASE_URL = data['base_url'];
    Api.BASE_URL = data['base_url'];
    // GeoPoint test = GeoPoint(123, 324);
  }
}

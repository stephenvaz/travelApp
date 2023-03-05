import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:travel_app/utils/MLocalStorage.dart';

class RecentChatsContoller extends GetxController {
  final friends = [].obs;

  RecentChatsContoller() {
      name();
  }

  Future<void> name() async {
    MLocalStorage().setEmailId("vedantpanchal12345@gmail.com");
    final f = await FirebaseFirestore.instance.collection("Users").doc("${MLocalStorage().getEmailId()}").get();
    friends.value = f['friends'];
    print(friends.value);
  }
}

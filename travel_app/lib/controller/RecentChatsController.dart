import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:travel_app/utils/MLocalStorage.dart';

class RecentChatsContoller extends GetxController {
  final friends = [].obs;
  final chats = [].obs;

  RecentChatsContoller() {
      name();
  }

  Future<void> name() async {
    MLocalStorage().setEmailId("vedantpanchal12345@gmail.com");
    final f = await FirebaseFirestore.instance.collection("Users").doc("${MLocalStorage().getEmailId()}").get();
    friends.value = f['friends'];

    chats.value = friends.value.map((e)  async {
        final mtest = await FirebaseFirestore.instance.collection("Users").doc("${MLocalStorage().getEmailId()}").get();
        return {
          "profile_photo": mtest['profile_photo'],
          "thread_id": mtest['thread_id'],
          "name": mtest['name'],
          "email": mtest['email']

        };
        return "test";

  }).toList();
    // for (final f in friends.value) {
    //   final f = await FirebaseFirestore.instance.collection("Users").doc("${MLocalStorage().getEmailId()}").get();
    //
    // }
    print(friends.value);
  }
}

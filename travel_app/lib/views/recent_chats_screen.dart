import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app/controller/RecentChatsController.dart';

final RecentChatsContoller recentChatsContoller = RecentChatsContoller();

class RecentChats extends StatelessWidget {
  const RecentChats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // recentChatsContoller.name();
    //gte
    return Obx(
      () => SafeArea(
        child: Scaffold(
          body: Center(
            child: ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) => Text("data"),
              itemCount: recentChatsContoller.friends.value.length,
            ),
          ),
        ),
      ),
    );
  }
}


//talk to tt
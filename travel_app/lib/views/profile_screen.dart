import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/utils/MLocalStorage.dart';
import 'package:travel_app/utils/MStyles.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Container(
            color: MStyles.pColor,
            child: Column(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(60))),

                      ),
                      // child: Container(width: 100,height: 100,)
                      radius: 65,
                    ),
                    CircleAvatar(
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.all(Radius.circular(60))),
                        child: Image.memory(
                          base64Decode(MLocalStorage().getImage()),
                          width: 120.w,
                        ),
                      ),
                      // child: Container(width: 100,height: 100,)
                      radius: 60,
                    )

                  ],
                ),
                Text("Name"),
                Row(
                  children: [
                    Column(
                      children: [
                        Text("10"),
                        Text("Trips")
                      ],
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    ));
  }
}

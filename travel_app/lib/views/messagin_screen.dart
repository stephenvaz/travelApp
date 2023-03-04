import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app/utils/MStyles.dart';
import 'package:travel_app/utils/generic_util.dart';

final mN = FocusNode();

final message = TextEditingController();

final theP = FirebaseFirestore.instance
    .collection('chats')
    .doc("tid")
    .collection("messages");

int count = 0;

// final myEmail = MLocalStorage().getEmailId();
final myEmail = "v@p";
final mSC = ScrollController();

class MessagingScreen extends StatefulWidget {
  MessagingScreen({Key? key}) : super(key: key);

  @override
  State<MessagingScreen> createState() => _MessagingScreenState();
}

class _MessagingScreenState extends State<MessagingScreen> {
  final sender = "v@p";

  final receiver = "s@v";

  @override
  void initState() {
    mN.addListener(() async {
      if (mN.hasPrimaryFocus) {
        try {
          await Future.delayed(Duration(milliseconds: 200));
          // mSC.animateTo(mSC.position.maxScrollExtent + 300,
          // mSC.animateTo(double.maxFinite,
          //     duration: Duration(milliseconds: 250), curve: Curves.decelerate);

          mSC.positions.isNotEmpty
              ? mSC.animateTo(mSC.position.maxScrollExtent + 70,
                  duration: Duration(milliseconds: 250),
                  curve: Curves.decelerate)
              : null;
        } catch (e) {}
      }
    });
  }

  // mNm
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // mSC.animateTo(mSC.position.maxScrollExtent + 70,
      // mSC.animateTo(double.maxFinite,
      //     duration: Duration(milliseconds: 250), curve: Curves.decelerate);

      mSC.positions.isNotEmpty
          ? mSC.animateTo(mSC.position.maxScrollExtent + 70,
              duration: Duration(milliseconds: 250), curve: Curves.decelerate)
          : null;

      // executes after build
    });
    return Scaffold(
      appBar: AppBar(
        actions: [
          Icon(
            Icons.videocam,
            size: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 1),
            child: Icon(
              Icons.call,
              size: 25,
            ),
          ),
          IconButton(
            onPressed: () {
              showMenu(
                  context: context,
                  position: RelativeRect.fromLTRB(100, 0, 0, 0),
                  items: [
                    PopupMenuItem(
                      child: Text("Report User"),
                      onTap: () async {
                        Get.back();
                        await Get.dialog(Center());
                        Get.dialog(Container(
                          child: Dialog(
                            child: Container(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Report User",
                                    style: MStyles.primaryTextStyle,
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Text(
                                      "By continuing, the last 5 messages will automatically be shared with us for scrutiny.\nMoreover, the user will be blocked."),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  ElevatedButton(
                                      onPressed: () {
                                        Get.back();
                                        GenericUtil.snackGeneric("Success",
                                            "User reported successfully");
                                      },
                                      child: Text("Report"))
                                ],
                              ),
                            ),
                          ),
                        ));
                        // showDialog(
                        //   context: context,
                        //   builder: (context) => Center(
                        //     child: Dialog(
                        //       child: Column(
                        //         mainAxisSize: MainAxisSize.min,
                        //         children: [
                        //           Text("Report User"),
                        //           Text(
                        //               "By continuing, the last 5 messages will automatically be shared with us for scrutiny.\nMoreover, the user will be blocked")
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // );
                      },
                    ),
                    PopupMenuItem(child: Text("Block User")),
                  ]);
            },
            icon: Icon(
              Icons.warning,
              size: 25,
            ),
          )
        ],
        leadingWidth: 20,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back)),
        title: Row(
          children: [
            ClipOval(
                child: Image.asset(
              'assets/images/sign_up_banner.png',
              height: 42,
            )),
            SizedBox(
              width: 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Pulkit Malhotra",
                  style: GoogleFonts.poppins(
                      fontSize: 18, fontWeight: FontWeight.w600),
                ),
                Text("online", style: GoogleFonts.poppins(fontSize: 10)),
              ],
            ),
          ],
        ),
      ), // bottomNavigationBar: Container(
      //   // width: 100,
      //   // height: 100,
      //   // color: Colors.orange,
      //   child: TextField(
      //     controller: message, // onTap: onTap,
      //     // readOnly: readOnly ?? false,
      //     // maxLines: maxLen ?? 1,
      //     // controller: mcont,
      //     decoration: InputDecoration(
      //       suffixIcon: IconButton(
      //         onPressed: () {
      //           count += 1;
      //           count = (count % 2);
      //
      //           theP.add({
      //             "sender": count == 0 ? sender : receiver,
      //             "receiver": count != 0 ? sender : receiver,
      //             "sent_at": DateTime.now().millisecondsSinceEpoch,
      //             "name": message.text,
      //             "message": message.text
      //           });
      //
      //           message.text = "";
      //         },
      //         icon: Icon(Icons.send),
      //       ),
      //       focusedBorder: UnderlineInputBorder(
      //         // borderRadius: BorderRadius.all(Radius.circular(10)),
      //         borderRadius: BorderRadius.zero,
      //         // borderRadius: (BorderRadius.all(Radius.circular(1000))),
      //         borderSide: BorderSide(
      //             color: MStyles.pColor, style: BorderStyle.none),
      //       ),
      //       enabledBorder: UnderlineInputBorder(
      //         // borderRadius: (BorderRadius.all(Radius.circular(100))),
      //         // borderRadius: (BorderRadius.all(Radius.circular(1000))),
      //         borderSide: BorderSide(
      //             color: MStyles.pColor, style: BorderStyle.none),
      //       ),
      //       // label: Text("Message"),
      //       hintText: "Message",
      //
      //       filled: true,
      //       // fillColor: MStyles.pColor.withOpacity(0.25),
      //       fillColor: MStyles.lightpColor,
      //     ),
      //   ),
      // ),
      body: Stack(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: theP.orderBy("sent_at").snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print(snapshot.data);
                print(snapshot.data);
                mSC.positions.isNotEmpty
                    ? mSC.animateTo(mSC.position.maxScrollExtent + 70,
                        duration: Duration(milliseconds: 250),
                        curve: Curves.decelerate)
                    : null;

                // return Text("test");
                return Padding(
                  padding: const EdgeInsets.only(bottom: 50.0),
                  child: ListView.builder(
                      controller: mSC,
                      // reverse: true,
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot doc = snapshot.data!.docs[index];

                        final isMe = doc["sender"] == myEmail;
                        return Container(
                          // decoration: BoxDecoration(
                          //   color: doc["sender"] == myEmail ? MStyles.pColor : Colors.black12
                          // ),
                          padding: EdgeInsets.all(8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              isMe
                                  ? Spacer()
                                  : Padding(
                                      padding: EdgeInsets.only(right: 8),
                                      child: ClipOval(
                                          child: Image.asset(
                                        'assets/images/sign_up_banner.png',
                                        height: 32,
                                      )),
                                    ),
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                    maxWidth: ScreenUtil().screenWidth * 0.6),
                                child: Container(
                                  margin: EdgeInsets.only(right: 16),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 16),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(16)),
                                      color: doc["sender"] == myEmail
                                          ? MStyles.pColor
                                          : Colors.black12),
                                  child: Text(
                                    doc["message"] + doc["sender"],
                                    style: GoogleFonts.poppins(
                                        color: doc["sender"] == myEmail
                                            ? Colors.white
                                            : MStyles.darkBgColor),
                                    softWrap: true,
                                  ),
                                ),
                              ),
                              !isMe ? Spacer() : Container(),
                            ],
                          ),
                        );
                        // return Text(doc['name'] + doc["sender"]);
                      }),
                );
              } else {
                return Center(child: Text("No data "));
              }
            },
          ),
          // Align(
          //   alignment: Alignment.bottomCenter,
          //   child: Row(
          //     children: [
          //       TextField(
          //         controller: message,
          //       ),
          //       FloatingActionButton(
          //         child: Text("+"),
          //         onPressed: () {
          //           theP.add({
          //             "s": "t1",
          //             "name": "test",
          //             "r": "t2",
          //             "sent_at": "t2",
          //           });
          //         },
          //       ),
          //     ],
          //   ),
          // ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              // width: 100,
              // height: 100,
              // color: Colors.orange,
              child: TextField(
                focusNode: mN, controller: message, // onTap: onTap,
                // readOnly: readOnly ?? false,
                // maxLines: maxLen ?? 1,
                // controller: mcont,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      count += 1;
                      count = (count % 2);

                      theP.add({
                        "sender": count == 0 ? sender : receiver,
                        "receiver": count != 0 ? sender : receiver,
                        "sent_at": DateTime.now().millisecondsSinceEpoch,
                        "name": message.text,
                        "message": message.text
                      });

                      message.text = "";
                    },
                    icon: Icon(Icons.send),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    // borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderRadius: BorderRadius.zero,
                    // borderRadius: (BorderRadius.all(Radius.circular(1000))),
                    borderSide: BorderSide(
                        color: MStyles.pColor, style: BorderStyle.none),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    // borderRadius: (BorderRadius.all(Radius.circular(100))),
                    // borderRadius: (BorderRadius.all(Radius.circular(1000))),
                    borderSide: BorderSide(
                        color: MStyles.pColor, style: BorderStyle.none),
                  ),
                  // label: Text("Message"),
                  hintText: "Message",

                  filled: true,
                  // fillColor: MStyles.pColor.withOpacity(0.25),
                  fillColor: MStyles.lightpColor,
                ),
              ),
            ),
          ),
          //             Align(
          // alignment: Alignment.topCenter,
          //               child: Container(
          //                 child: Row(children: [
          //
          //                 ],),
          //               ),
          //             )
        ],
      ),
    );
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app/utils/MLocalStorage.dart';
import 'package:travel_app/utils/MStyles.dart';
import 'package:travel_app/utils/generic_util.dart';
//api
import 'package:travel_app/api/api.dart';
//image
import 'package:image_picker/image_picker.dart';

class Community extends StatefulWidget {
  const Community({super.key});

  @override
  State<Community> createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  RxBool isLoading = false.obs;

  late List list;
  @override
  void initState() {
    super.initState();
    isLoading.value = true;
    // Api().getCommunitites("malay@spit.ac.in").then((value) {
    Api().getCommunitites(MLocalStorage().getEmailId()).then((value) {
      // print(value);
      Map data = Map.from(value);
      list = data['Communities'];
      isLoading.value = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      backgroundColor: MStyles.pColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CreateCommunity()));
        },
        backgroundColor: Colors.white,
        child: Icon(
          Icons.add_rounded,
          size: 32,
          color: MStyles.pColor,
        ),
      ),
      appBar: AppBar(
        title: Text('Community'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () {
                    //TODO: Search through events
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(32)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4.0, vertical: 2.0),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.search_rounded,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "search",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                InkWell(
                  onTap: () {
                    //TODO: Search through events
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(32)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4.0, vertical: 2.0),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.filter_list_rounded,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "filters",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            Obx(() {
              return (!isLoading.value)
                  ? Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: list.length, //
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: CommunityTile(
                                title: list[index]['title'],
                                desc: list[index]['desc'],
                                date: list[index]['date'],
                                imageUrl: list[index]['imageUrl'],
                              ),
                            );
                          }),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(top: 32.0),
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    );
            })
          ],
        ),
      ),
    );
  }
}

class CommunityTile extends StatelessWidget {
  const CommunityTile({
    super.key,
    required this.title,
    required this.desc,
    required this.date,
    this.imageUrl,
  });
  final String title;
  final String desc;
  final String date;
  final String? imageUrl;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16)),
            child: (imageUrl == null)
                ? Image.network(
                    "https://images.unsplash.com/photo-1677856216846-596a3d6d869e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyfHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=1400&q=60")
                : Builder(builder: (context) {
                    var bytes = base64Decode(imageUrl!);
                    return Image.memory(bytes);
                  }),
          ),
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16))),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                          color: MStyles.pColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Color(0xFF64F761)),
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(32)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 2.0),
                          child: Text(
                            "join",
                            style: TextStyle(
                              color: Color(0xFF64F761),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(desc,
                        style: TextStyle(
                            color:
                                MStyles.pColorWithTransparency.withOpacity(0.4),
                            fontWeight: FontWeight.bold,
                            fontSize: 14)),
                  ],
                ),
                Text(DateTime.parse(date).day.toString() +
                    "/" +
                    DateTime.parse(date).month.toString() +
                    "/" +
                    DateTime.parse(date).year.toString()),
                Text("Event Time"),
                Text("Event Location"),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class CreateCommunity extends StatefulWidget {
  const CreateCommunity({super.key});

  @override
  State<CreateCommunity> createState() => _CreateCommunityState();
}

//title, description, date, email
TextEditingController title = TextEditingController();
TextEditingController description = TextEditingController();
DateTime startDate = DateTime.now();
TextEditingController email = TextEditingController();
late File imageFile;

class _CreateCommunityState extends State<CreateCommunity> {
  RxBool submitted = false.obs;
  RxBool clicked = false.obs;
  _getFromGallery() async {
    PickedFile pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    ) as PickedFile;
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      clicked.value = true;
    } else {
      clicked.value = false;
    }
  }

  _getFromCamera() async {
    XFile pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    ) as XFile;
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      clicked.value = true;
    } else {
      clicked.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: MStyles.pColor,
      appBar: AppBar(
        title: Text('Create Community'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      context: context,
                      builder: (context) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16)),
                          ),
                          // height: 200,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  onTap: () {
                                    _getFromGallery();
                                  },
                                  leading: Icon(Icons.image),
                                  title: Text("Gallery"),
                                ),
                                ListTile(
                                  onTap: () {
                                    _getFromCamera();
                                  },
                                  leading: Icon(Icons.camera),
                                  title: Text("Camera"),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Container(
                    height: 400,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16)),
                    child: Center(
                      child: Obx(() {
                        return (!clicked.value)
                            ? Icon(
                                Icons.add_a_photo,
                                size: 50,
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.file(File(imageFile.path)),
                              );
                      }),
                    ),
                  ),
                ),
              ),
              MTextField(label: "Title", mcont: title),
              MTextField(label: "Description", mcont: description),
              MTextField(label: "Email", mcont: email),
              InkWell(
                  onTap: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(Duration(days: 365 * 100)),
                    ).then((value) {
                      setState(() {
                        startDate = value ?? DateTime.now();
                      });
                      // print(startDate);
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: MStyles.pColorWithTransparency, width: 2),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.date_range_rounded),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            (startDate.year != 0000)
                                ? "${startDate.day}/${startDate.month}/${startDate.year}"
                                : "Start Date",
                            style: TextStyle(
                                // color: Colors.white,
                                fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  )),
              Obx(() {
                return (!submitted.value)
                    ? ElevatedButton(
                        onPressed: () async {
                          submitted.value = true;
                          //TODO: conversion to base 64
                          final bytes = await imageFile.readAsBytes();
                          String img64 = base64Encode(bytes);
                          var payload = {
                            "title": title.text,
                            "desc": description.text,
                            "date": startDate.toString(),
                            "email": email.text,
                            "imageUrl": img64,
                          };
                          print(payload);
                          Map res = await Api().createCommunity(payload);
                          if (res['status'] == 1) {
                            print("successful");
                            Get.closeAllSnackbars();
                            Get.snackbar('Succesful', "Trip Added",
                                backgroundColor: MStyles.pColor);

                            //TODO: NAVIGATE TO SOME OTHER SCREEN, MAYBE PROFILE OR JUST POP BACK
                            Navigator.pop(context);
                          } else {
                            Get.closeAllSnackbars();
                            Get.snackbar("Error", "Please try again");
                          }
                          submitted.value = false;
                        },
                        child: Text("Submit"))
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: const CircularProgressIndicator(),
                      );
              })
            ],
          ),
        ),
      ),
    );
  }
}

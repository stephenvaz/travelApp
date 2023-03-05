import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:travel_app/api/api.dart';
import 'package:travel_app/utils/MLocalStorage.dart';
import 'package:travel_app/utils/MStyles.dart';
import 'package:travel_app/views/sign_up.dart';

class SimilarTrip extends StatefulWidget {
  const SimilarTrip({super.key});

  @override
  State<SimilarTrip> createState() => _SimilarTripState();
}

class _SimilarTripState extends State<SimilarTrip> {
  RxBool _type = false.obs;
  RxBool _isLoading = true.obs;
  late List _nearby;
  late List _recvd;
  @override
  void initState() {
    super.initState();
    _isLoading.value = true;
    Api().getNearby(MLocalStorage().getEmailId()).then((value) {
      print(value);
      Map nb = value;
      _nearby = nb["arr"];
      _isLoading.value = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MStyles.pColor,
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          children: [
            Text('View people on'),
            Text('similar trips'),
          ],
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // InkWell(
                //   onTap: () {
                //     //TODO: Search through events
                //   },
                //   child: Container(
                //     decoration: BoxDecoration(
                //         border: Border.all(color: Colors.white),
                //         borderRadius: BorderRadius.circular(32)),
                //     child: Padding(
                //       padding: const EdgeInsets.symmetric(
                //           horizontal: 4.0, vertical: 2.0),
                //       child: Row(
                //         children: const [
                //           Text(
                //             "filters",
                //             style: TextStyle(color: Colors.white, fontSize: 16),
                //           ),
                //           SizedBox(
                //             width: 5,
                //           ),
                //           Icon(
                //             Icons.filter_list_rounded,
                //             color: Colors.white,
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                InkWell(
                  onTap: () {
                    //TODO: Search through events
                    _type.value = !_type.value;
                  },
                  child: Obx(() {
                    return Container(
                      decoration: BoxDecoration(
                          color: _type.value ? Colors.white : null,
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(32)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 2.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.people_outline_rounded,
                              color:
                                  (_type.value) ? MStyles.pColor : Colors.white,
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(() {
              return (!_type.value)
                  ? (!_isLoading.value)
                      ? ListView.builder(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return RequestTile(
                              name: _nearby[index]["name"],
                              source: _nearby[index]["start_location"],
                              destination: _nearby[index]["end_location"],
                              date: _nearby[index]["start_date"],
                              email: _nearby[index]["user"],
                            );
                          },
                          itemCount: _nearby.length)
                      : const CircularProgressIndicator()
                  : BottomSheet();
            }),
          ),
        ],
      ),
    );
  }
}

class BottomSheet extends StatefulWidget {
  const BottomSheet({
    super.key,
  });

  @override
  State<BottomSheet> createState() => _BottomSheetState();
}

class _BottomSheetState extends State<BottomSheet> {
  RxBool _isPending = true.obs;
  late List recvd;
  late List pend;
  RxBool _isLoadingPend = false.obs;
  RxBool _isLoadingRecvd = false.obs;

  @override
  void initState() {
    super.initState();
    _isLoadingPend.value = true;
    Api().pending(MLocalStorage().getEmailId()).then((value) {
      Map data = value;
      pend = data['list'];
      _isLoadingPend.value = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () async {
                  if (_isLoadingPend.value) {
                    return;
                  }
                  _isPending.value = !_isPending.value;
                  if (_isPending.value) {
                    _isLoadingPend.value = true;
                    Api().pending(MLocalStorage().getEmailId()).then((value) {
                      Map data = value;
                      pend = data['list'];
                      _isLoadingPend.value = false;
                    });
                  }
                },
                child: Obx(() {
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: MStyles.pColor),
                      color: (_isPending.value) ? MStyles.pColor : null,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Pending Requests",
                        style: TextStyle(
                            color: (!_isPending.value)
                                ? MStyles.pColor
                                : Colors.white),
                      ),
                    ),
                  );
                }),
              ),
              InkWell(
                onTap: () {
                  if (_isLoadingRecvd.value) {
                    return;
                  }
                  _isPending.value = !_isPending.value;
                  if (!_isPending.value) {
                    _isLoadingRecvd.value = true;
                    Api().recvreq(MLocalStorage().getEmailId()).then((value) {
                      Map data = value;
                      recvd = data['list'];
                      _isLoadingRecvd.value = false;
                    });
                  }
                  // _isLoadingRecvd.value = true;
                  // Api().recvreq("vedantpanchal12345@gmail.com").then((value) {
                  //   Map data = value;
                  //   recvd = data['list'];
                  //   _isLoadingRecvd.value = false;
                  // });
                },
                child: Obx(() {
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: MStyles.pColor),
                      color: (!_isPending.value) ? MStyles.pColor : null,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Recieved Requests",
                        style: TextStyle(
                            color: (_isPending.value)
                                ? MStyles.pColor
                                : Colors.white),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
          Obx(() {
            return (!_isPending.value &&
                    !_isLoadingRecvd
                        .value) // should show list when loading is false and isPending is true
                ? Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: recvd.length,
                        itemBuilder: (context, index) {
                          return ReqTile(
                            email: recvd[index]["email"],
                          );
                        }),
                  )
                : const SizedBox();
          }),
          Obx(() {
            return (_isPending.value &&
                    !_isLoadingPend
                        .value) // should show list when loading is false and isPending is true
                ? Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: pend.length,
                        itemBuilder: (context, index) {
                          return ReqTile(
                            email: pend[index]["email"],
                            ar: false,
                          );
                        }),
                  )
                : const SizedBox();
          }),
        ]),
      ),
    );
  }
}

class ReqTile extends StatefulWidget {
  const ReqTile({super.key, required this.email, this.ar});
  final String email;
  final bool? ar;

  @override
  State<ReqTile> createState() => _ReqTileState();
}

class _ReqTileState extends State<ReqTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: MStyles.pColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey[300],
                    child: Text(
                      widget.email[0].toUpperCase(),
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.6,
                  ),
                  child: Text(
                    widget.email,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                (widget.ar != false)
                    ? Row(
                        children: [
                          InkWell(
                            onTap: () async {
                              Map res = await Api().accept(
                                  widget.email, MLocalStorage().getEmailId());
                              if (res["status"] == 1) {
                                Get.closeAllSnackbars();
                                Get.snackbar(
                                  "Success",
                                  "Request Sent",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.green,
                                  colorText: Colors.white,
                                );
                              } else {
                                Get.closeAllSnackbars();
                                Get.snackbar(
                                  "Error",
                                  "Something went wrong",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white,
                                );
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Color(0xFF64F761)),
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(32)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 2.0),
                                child: Text(
                                  "Accept",
                                  style: TextStyle(
                                    color: Color(0xFF64F761),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () async {
                              Map res = await Api().reject(
                                  widget.email, MLocalStorage().getEmailId());
                              if (res["status"] == 1) {
                                Get.closeAllSnackbars();
                                Get.snackbar(
                                  "Success",
                                  "Request Sent",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.green,
                                  colorText: Colors.white,
                                );
                              } else {
                                Get.closeAllSnackbars();
                                Get.snackbar(
                                  "Error",
                                  "Something went wrong",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white,
                                );
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.red),
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(32)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 2.0),
                                child: Text(
                                  "Reject",
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : SizedBox(),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class RequestTile extends StatefulWidget {
  const RequestTile(
      {super.key,
      required this.name,
      required this.source,
      required this.destination,
      required this.date,
      required this.email});

  final String name;
  final String source;
  final String destination;
  final String date;
  final String email;
  @override
  State<RequestTile> createState() => _RequestTileState();
}

class _RequestTileState extends State<RequestTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey[300],
                    child: Text(
                      widget.name[0],
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.7,
                    ),
                    child: Wrap(
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.source,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.grey,
                        ),
                        Text(
                          widget.destination,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Text(
                  "${DateTime.parse(widget.date).day}/${DateTime.parse(widget.date).month}/${DateTime.parse(widget.date).year}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () async {
                        Map res = await Api()
                            .send(widget.email, MLocalStorage().getEmailId());
                        if (res["status"] == 1) {
                          Get.closeAllSnackbars();
                          Get.snackbar(
                            "Success",
                            "Request Sent",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.green,
                            colorText: Colors.white,
                          );
                        } else {
                          Get.closeAllSnackbars();
                          Get.snackbar(
                            "Error",
                            "Something went wrong",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                          );
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Color(0xFF64F761)),
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(32)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 2.0),
                          child: Text(
                            "Send",
                            style: TextStyle(
                              color: Color(0xFF64F761),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

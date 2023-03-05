import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app/api/api.dart';
import 'package:travel_app/utils/MLocalStorage.dart';
import 'package:travel_app/utils/MStyles.dart';

class Trips extends StatefulWidget {
  const Trips({super.key});

  @override
  State<Trips> createState() => _TripsState();
}

class _TripsState extends State<Trips> {
  RxBool _isLoading = true.obs;
  late List _trips;
  @override
  void initState() {
    super.initState();
    Api().trips(MLocalStorage().getEmailId()).then((value) {
      Map data = value;
      _trips = data["list"];
      _isLoading.value = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MStyles.pColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text("Trips"),
      ),
      body: Column(
        children: [
          Obx(() {
            return (!_isLoading.value)
                ? Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: _trips.length,
                        itemBuilder: (context, index) {
                          return TripTile(
                              start: _trips[index]["start_location"],
                              dest: _trips[index]["end_location"],
                              date: _trips[index]["start_date"]);
                        }),
                  )
                : Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  );
          })
        ],
      ),
    );
  }
}

class TripTile extends StatefulWidget {
  const TripTile(
      {super.key, required this.start, required this.dest, required this.date});
  final String start;
  final String dest;
  final String date;
  @override
  State<TripTile> createState() => _TripTileState();
}

class _TripTileState extends State<TripTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              // minWidth: 100,
              // minHeight: 100,
              maxWidth: MediaQuery.of(context).size.width * 0.6,
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: MStyles.pColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    widget.start,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: MStyles.pColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    widget.dest,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "${DateTime.parse(widget.date.toString()).day}/${DateTime.parse(widget.date.toString()).month}/${DateTime.parse(widget.date.toString()).year}",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: MStyles.pColorWithTransparency.withOpacity(0.5)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

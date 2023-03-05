import 'package:dropdown_search/dropdown_search.dart' as dd;
import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:get/get.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

//api
import 'package:travel_app/api/api.dart';
import 'package:travel_app/utils/MLocalStorage.dart';
import 'package:travel_app/utils/MStyles.dart';

class MapSearch extends StatefulWidget {
  const MapSearch({super.key});

  @override
  State<MapSearch> createState() => _MapSearchState();
}

//chip should be preloaded from profile data
var startObject;
var endObject;
List submitStops = [];
String source = "Source";
String destination = "Destination";

class _MapSearchState extends State<MapSearch> {
  String googleApikey = "AIzaSyA6dLwXYiuDDo26s5Jb46Y0jSqKeLSdC_Q";
  GoogleMapController? mapController; //co5ntrller for Google map
  CameraPosition? cameraPosition;
  LatLng startLocation = LatLng(19.107380265566505, 72.837150475571);
  // String source = "Source";
  // String destination = "Destination";
  String description = "";
  RxInt stops = 0.obs;
  List<String> stopnames = [];
  DateTime startDate = DateTime(0000);
  DateTime endDate = DateTime(0000);
  DraggableScrollableController dragControl = DraggableScrollableController();
  RxBool isNext = false.obs;
  List<String> selectedChip = [];
  RxBool submitted = false.obs;
  List<String> interestChips = [
    "Scuba diving",
    "Hiking",
    "Backpacking",
    "Food tours",
    "Wine tasting",
    "Wildlife safaris",
    "Road trips",
    "Beach vacations",
    "Cultural tours",
    "Volunteering",
    "Cycling",
    "Surfing",
    "Snowboarding",
    "Skiing",
    "Mountaineering",
    "Camping",
    "Photography",
    "City breaks",
    "Luxury travel",
    "Cruise vacations",
    "Adventure travel",
    "Train journeys",
    "Festivals",
    "Spiritual retreats",
    "Yoga retreats",
    "Glamping",
    "Sailing",
    "Kayaking",
    "Canoeing",
    "Fishing",
    "Sightseeing",
    "Historical tours",
    "Archaeological tours",
    "Nature walks",
    "River rafting",
    "Ziplining",
    "Bungee jumping",
    "Skydiving",
    "Paragliding",
    "Hot air balloon rides",
    "Safari tours",
    "Motorbike tours",
    "Backcountry skiing",
    "Helicopter tours",
    "Island hopping",
    "Snorkeling",
    "Dolphin watching",
    "Whale watching",
    "Rock climbing"
  ];

  String transport = '';

  @override
  void initState() {
    super.initState();
    // Geolocator.getCurrentPosition().then((value) => setState(
    //     () => startLocation = LatLng(value.latitude, value.longitude)));
  }

  @override
  Widget build(BuildContext context) {
    return  TweenAnimationBuilder(
      builder: (context, value, child) => value != 1 ? Center(child: CircularProgressIndicator()) : Obx(() {
        return Scaffold(
            resizeToAvoidBottomInset: (isNext.value) ? true : false,
            // appBar: AppBar(
            //   title: Text("Place Search Autocomplete Google Map"),
            //   backgroundColor: Colors.deepPurpleAccent,
            // ),
            body: Stack(children: [
              GoogleMap(
                //Map widget from google_maps_flutter package
                zoomGesturesEnabled: true, //enable Zoom in, out on map
                initialCameraPosition: CameraPosition(
                  //innital position in map
                  target: startLocation, //initial position
                  zoom: 14.0, //initial zoom level
                ),
                mapType: MapType.normal, //map type
                onMapCreated: (controller) {
                  //method called when map is created
                  setState(() {
                    mapController = controller;
                  });
                },
              ),
              Positioned(
                  top: 20,
                  left: 10,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )),
              Positioned(
                  child: DraggableScrollableSheet(
                minChildSize: 0.2,
                initialChildSize: 0.3,
                maxChildSize: 0.92,
                controller: dragControl,
                builder: (context, scrollController) {
                  return Container(
                    decoration: BoxDecoration(
                        color: MStyles.pColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Theme(
                          data: ThemeData(),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Add Trip",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Obx(() {
                                      return (isNext.value)
                                          ? IconButton(
                                              onPressed: () {
                                                isNext.value = false;
                                                dragControl.animateTo(0.30,
                                                    duration: Duration(
                                                        milliseconds: 500),
                                                    curve: Curves.linear);
                                              },
                                              icon: Icon(
                                                  Icons.arrow_downward_rounded))
                                          : const SizedBox();
                                    }),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        TripContainer(
                                          location: source,
                                          mapController: mapController,
                                          googleApikey: googleApikey,
                                          icon: Icons.circle_outlined,
                                          srcDest: true,
                                        ),
                                        Obx(() {
                                          return ListView.builder(
                                              padding: EdgeInsets.zero,
                                              shrinkWrap: true,
                                              itemCount: stops.value,
                                              itemBuilder: (context, index) {
                                                return TripContainer(
                                                  stopslist: stopnames,
                                                  mapController: mapController,
                                                  googleApikey: googleApikey,
                                                  icon: Icons.circle_outlined,
                                                  index: index,
                                                );
                                              });
                                        }),
                                        TripContainer(
                                          location: destination,
                                          mapController: mapController,
                                          googleApikey: googleApikey,
                                          icon: Icons.location_on,
                                          srcDest: false,
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        stops.value++;
                                      },
                                      icon: Icon(Icons.add))
                                ],
                              ),
                              Obx(() {
                                return (!isNext.value)
                                    ? ElevatedButton(
                                        onPressed: () {
                                          isNext.value = true;
                                          print(stopnames);
                                          // scrollController.animateTo(
                                          //     scrollController.position.maxScrollExtent,
                                          //     duration: Duration(milliseconds: 500),
                                          //     curve: Curves.linear);
                                          dragControl.animateTo(0.90,
                                              duration:
                                                  Duration(milliseconds: 500),
                                              curve: Curves.linear);
                                        },
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStatePropertyAll(
                                                    Colors.transparent),
                                            side: MaterialStatePropertyAll(
                                                BorderSide(
                                                    color: Colors.white,
                                                    width: 2)),
                                            shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            32)))),
                                        child: Text("Next"))
                                    : Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                8.0, 8.0, 54.0, 8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  Icons.date_range,
                                                  color: Colors.white,
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Expanded(
                                                  child: InkWell(
                                                    onTap: () {
                                                      showDatePicker(
                                                        context: context,
                                                        initialDate:
                                                            DateTime.now(),
                                                        firstDate: DateTime.now(),
                                                        lastDate: DateTime.now()
                                                            .add(Duration(
                                                                days: 365 * 100)),
                                                      ).then((value) {
                                                        setState(() {
                                                          startDate = value!;
                                                        });
                                                        print(startDate);
                                                      });
                                                    },
                                                    child: Container(
                                                      padding: EdgeInsets.zero,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color: Colors.white,
                                                              width: 2),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10)),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        child: Text(
                                                          (startDate.year != 0000)
                                                              ? "${startDate.day}/${startDate.month}/${startDate.year}"
                                                              : "Start Date",
                                                          style: TextStyle(
                                                              // color: Colors.white,
                                                              fontSize: 18),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                8.0, 8.0, 54.0, 8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  Icons.date_range,
                                                  color: Colors.white,
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Expanded(
                                                  child: InkWell(
                                                    onTap: () {
                                                      showDatePicker(
                                                        context: context,
                                                        initialDate:
                                                            DateTime.now(),
                                                        firstDate: DateTime.now(),
                                                        lastDate: DateTime.now()
                                                            .add(Duration(
                                                                days: 365 * 100)),
                                                      ).then((value) {
                                                        setState(() {
                                                          endDate = value!;
                                                        });
                                                        print(endDate);
                                                      });
                                                    },
                                                    child: Container(
                                                      padding: EdgeInsets.zero,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color: Colors.white,
                                                              width: 2),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10)),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        child: Text(
                                                          (endDate.year != 0000)
                                                              ? "${endDate.day}/${endDate.month}/${endDate.year}"
                                                              : "End Date",
                                                          style: TextStyle(
                                                              // color: Colors.white,
                                                              fontSize: 18),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextFormField(
                                              onChanged: (value) => setState(() {
                                                description = value;
                                              }),
                                              decoration: InputDecoration(
                                                  focusedBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.white),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color:
                                                                  Colors.white),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10)),
                                                  border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.white),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  hintText:
                                                      'Description (Optional)'),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextFormField(
                                              onChanged: (value) => setState(() {
                                                transport = value;
                                              }),
                                              decoration: InputDecoration(
                                                  focusedBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.white),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color:
                                                                  Colors.white),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10)),
                                                  border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.white),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  hintText: 'Mode Of Transport'),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: dd.DropdownSearch(
                                              popupProps: dd.PopupProps.dialog(),
                                              dropdownDecoratorProps:
                                                  dd.DropDownDecoratorProps(),
                                              // showSelectedItem: true,
                                              items: interestChips,
                                              // label: "Select Frequency",

                                            onChanged: (value) {
                                              // setState(() {
                                              //   frequency = value;
                                              // });
                                              setState(() {
                                                selectedChip.add(value!);
                                              });
                                              print(value);
                                            },
                                          ),
                                        ),
                                        Container(
                                          height: 100,
                                          child: ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: selectedChip.length,
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (context, index) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Chip(
                                                    label: Text(
                                                        selectedChip[index]),
                                                  ),
                                                );
                                              }),
                                        ),
                                        Obx(() {
                                          return (!submitted.value)
                                              ? ElevatedButton(
                                                  onPressed: () async {
                                                    submitted.value = true;
                                                    var newstops = [];
                                                    newstops.add(startObject);
                                                    for (int i = 0;
                                                        i < submitStops.length;
                                                        i++) {
                                                      newstops
                                                          .add(submitStops[i]);
                                                    }
                                                    newstops.add(endObject);
                                                    String status =
                                                        "Not Yet Started";
                                                    if (DateTime.now()
                                                        .isAfter(startDate)) {
                                                      status = "Started";
                                                    }

                                                    var payload = {
                                                      "start_date": startDate,
                                                      "end_date": endDate,
                                                      "stops": newstops,
                                                      "mode_of_transport":
                                                          transport,
                                                      "interests": selectedChip,
                                                      "status": status
                                                    };
                                                    Map res = await Api()
                                                        .addTrip(payload);
                                                    // print(r)

                                                    print("payload");
                                                    print(payload);
                                                    if (res['status'] == 1) {
                                                      print("successful");
                                                      Get.closeAllSnackbars();
                                                      Get.snackbar('Succesful',
                                                          "Trip Added",
                                                          backgroundColor:
                                                              MStyles.pColor);

                                                      //TODO: NAVIGATE TO SOME OTHER SCREEN, MAYBE PROFILE OR JUST POP BACK
                                                    } else {
                                                      Get.closeAllSnackbars();
                                                      Get.snackbar("Error",
                                                          "Please try again");
                                                    }
                                                    submitted.value = false;
                                                  },
                                                  style: ButtonStyle(
                                                    side:
                                                        MaterialStatePropertyAll(
                                                            BorderSide(
                                                                width: 2,
                                                                color: Colors
                                                                    .white)),
                                                    shape: MaterialStateProperty
                                                        .all(RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        32))),
                                                  ),
                                                  child: Text("Submit"))
                                              : const CircularProgressIndicator();
                                        })
                                      ],
                                    );
                            })
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            )),
          ]));
    });
  }
}

class TripContainer extends StatefulWidget {
  TripContainer(
      {this.location,
      required this.mapController,
      required this.googleApikey,
      required this.icon,
      this.stopslist,
      this.index,
      this.srcDest});
  String? location;
  final GoogleMapController? mapController;
  final String googleApikey;
  final IconData icon;
  List? stopslist;
  final int? index;
  final bool? srcDest; //true -> source, false -> dest, null -> stops
  @override
  State<TripContainer> createState() => _TripContainerState();
}

class _TripContainerState extends State<TripContainer> {
  bool added = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Icon(widget.icon, color: Colors.white),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(10)),
              child: InkWell(
                onTap: () async {
                  var place = await PlacesAutocomplete.show(
                      context: context,
                      apiKey: widget.googleApikey,
                      mode: Mode.overlay,
                      types: [],
                      strictbounds: false,
                      onError: (err) {
                        print(err);
                      });

                  if (place != null) {
                    setState(() {
                      if (widget.index != null) {
                        widget.stopslist?.add(place.description.toString());
                        added = true;
                      } else {
                        widget.location = place.description.toString();
                      }
                    });

                    //form google_maps_webservice package
                    final plist = GoogleMapsPlaces(
                      apiKey: widget.googleApikey,
                      apiHeaders: await GoogleApiHeaders().getHeaders(),
                      //from google_api_headers package
                    );
                    String placeid = place.placeId ?? "0";
                    final detail = await plist.getDetailsByPlaceId(placeid);
                    final geometry = detail.result.geometry!;
                    final lat = geometry.location.lat;
                    final lang = geometry.location.lng;
                    var newlatlang = LatLng(lat, lang);

                    //move map camera to selected place with animation
                    widget.mapController?.animateCamera(
                        CameraUpdate.newCameraPosition(
                            CameraPosition(target: newlatlang, zoom: 17)));
                    //create object of below three values
                    print(place.description);
                    print(lat);
                    print(lang);
                    // if (widget.index != null) {
                    //   startObject = {
                    // "location_name": place.description,
                    // "lat": lat,
                    // "lng": lang
                    //   };
                    //   print(startObject);
                    // }
                    var locObj = {
                      "location_name": place.description,
                      "lat": lat,
                      "lng": lang
                    };
                    if (widget.srcDest == true) {
                      startObject = locObj;
                      print("source");
                      source = place.description ?? 'Source';
                      print(startObject);
                    } else if (widget.srcDest == false) {
                      endObject = locObj;
                      print("dest");
                      destination = place.description ?? "Destination";
                      print(endObject);
                    } else {
                      submitStops.add(locObj);
                      print("stops");
                      print(submitStops);
                    }
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      (widget.index != null)
                          ? (added)
                              ? widget.stopslist![widget.index!]
                              : "Add Stop"
                          : widget.location,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

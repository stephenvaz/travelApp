import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app/controller/HomeController.dart';
import 'package:travel_app/utils/MStyles.dart';

final homeController  = HomeController();

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      bottomNavigationBar: Obx(
        () =>  BottomNavigationBar(
          elevation: 0,
          backgroundColor: MStyles.pColor,
          fixedColor: MStyles.col4,
          currentIndex: homeController.currIndex.value,
          onTap: (int p) {
            homeController.changeIndex(p);
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home', backgroundColor: MStyles.pColor),
            BottomNavigationBarItem(icon: Icon(Icons.route), label: 'Trips'),
            BottomNavigationBarItem(icon: Icon(Icons.calendar_month_rounded), label: 'Events'),
            BottomNavigationBarItem(icon: Icon(Icons.message_rounded), label: 'Chat'),
          ],
        ),
      ),
      body: Stack(
        children: [
          Image.asset('assets/images/home_banner.png'),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            margin: EdgeInsets.only(top: ScreenUtil().screenHeight * 0.3),
            width: double.maxFinite,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.w),
                    topRight: Radius.circular(20.w)),
                color: MStyles.pColor),
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(maxWidth: ScreenUtil().screenWidth - 64),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Events",
                            style: MStyles.primaryTextStyle
                                .copyWith(color: Colors.white),
                          ),
                          ConstrainedBox(
                              constraints: BoxConstraints(
                                  maxWidth: ScreenUtil().screenWidth * 0.5),
                              child: Text(
                                "Meet new people at events at your travel locations!",
                                style: GoogleFonts.poppins(color: Colors.white),
                              ))
                        ],
                      ),
                      Spacer(),
                      OutlinedButton(
                          onPressed: () {},
                          child: Text(
                            "View More",
                            style: GoogleFonts.poppins(
                                // color: MStyles.col4
                                color: Colors.white),
                          ),
                          style: OutlinedButton.styleFrom(
                              // foregroundColor:                          MStyles.col4
                              side: BorderSide(
                                  // color: MStyles.col4,
                                  color: Colors.white,
                                  width: 2),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100)))))
                    ],
                  ),
                  Container(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            color: Colors.orange,
                            width: 100,
                            height: 80,
                          ),
                        );
                      },
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Hangouts",
                            style: MStyles.primaryTextStyle
                                .copyWith(color: Colors.white),
                          ),
                          ConstrainedBox(
                              constraints: BoxConstraints(
                                  maxWidth: ScreenUtil().screenWidth * 0.5),
                              child: Text(
                                "Plan one to one catch-ups for the places you want to visit together",
                                style: GoogleFonts.poppins(color: Colors.white),
                              ))
                        ],
                      ),
                      Spacer(),
                      OutlinedButton(
                          onPressed: () {},
                          child: Text(
                            "View More",
                            style: GoogleFonts.poppins(
                                // color: MStyles.col4
                                color: Colors.white),
                          ),
                          style: OutlinedButton.styleFrom(
                              // foregroundColor:                          MStyles.col4
                              side: BorderSide(
                                  // color: MStyles.col4,
                                  color: Colors.white,
                                  width: 2),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100)))))
                    ],
                  ),
                  Column(
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            //user images here

                            Container(
                              color: Colors.orange,
                              width: 100,
                              height: 80,
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Container(
                              color: Colors.orange,
                              width: 100,
                              height: 80,
                            ),
                            Container(
                              color: Colors.orange,
                              width: 100,
                              height: 80,
                            ),
                            Container(
                              color: Colors.orange,
                              width: 100,
                              height: 80,
                            )
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}

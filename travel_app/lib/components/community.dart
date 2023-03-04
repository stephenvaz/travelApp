import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/utils/MStyles.dart';

class Community extends StatefulWidget {
  const Community({super.key});

  @override
  State<Community> createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      backgroundColor: MStyles.pColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CreateCommunity()));
          // showGeneralDialog(
          //     context: context,
          //     pageBuilder: (context, anim1, anim2) {
          //       return Material(
          //         color: Colors.transparent,
          //         child: Padding(
          //           padding: const EdgeInsets.symmetric(
          //               vertical: 64.0, horizontal: 32.0),
          //           child: Container(
          //             decoration: BoxDecoration(
          //                 color: MStyles.pColor.withOpacity(0.8),
          //                 borderRadius: BorderRadius.circular(16)),
          //             child: Padding(
          //               padding: const EdgeInsets.all(8.0),
          //               child: Column(
          //                 children: [
          //                   Stack(
          //                     children: [
          //                       Align(
          //                         alignment: Alignment.center,
          //                         child: Text(
          //                           "Create",
          //                           style: TextStyle(
          //                               fontSize: 18,
          //                               color: Colors.white,
          //                               fontWeight: FontWeight.bold),
          //                         ),
          //                       )
          //                     ],
          //                   )
          //                 ],
          //               ),
          //             ),
          //           ),
          //         ),
          //       );
          //     });
        },
        backgroundColor: MStyles.lightBgColor,
        child: Icon(
          Icons.add_rounded,
          size: 32,
          color: Colors.white,
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
                            Icons.menu,
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
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 3, //
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: CommunityTile(
                        title: "events",
                      ),
                    );
                  }),
            )
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
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16)),
            child: Image.network(
                "https://images.unsplash.com/photo-1677856216846-596a3d6d869e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyfHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=1400&q=60"),
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
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                          color: MStyles.pColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        "Join",
                        style: TextStyle(color: Color(0xFF64F761)),
                      ),
                      style: ButtonStyle(
                          padding: MaterialStatePropertyAll(EdgeInsets.zero),
                          elevation: MaterialStateProperty.all(0),
                          side: MaterialStatePropertyAll(
                            BorderSide(color: Color(0xFF64F761)),
                          ),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32))),
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.transparent)),
                    ),
                  ],
                ),
                Text("Event Description"),
                Text("Event Date"),
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

class _CreateCommunityState extends State<CreateCommunity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Community'),
        centerTitle: true,
        elevation: 0,
      ),
    );
  }
}

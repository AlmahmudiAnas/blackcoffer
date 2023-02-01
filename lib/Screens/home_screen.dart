import 'package:blackcoffer/Module/videos_list.dart';
import 'package:blackcoffer/Screens/record_video.dart';
import 'package:blackcoffer/Screens/shimmer.dart';
import 'package:blackcoffer/Screens/video_details.dart';
import 'package:blackcoffer/consts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../My Widgets/video_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static String routeName = 'Home Screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var title, userName, location, category, userPhotoURL;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        leading: Container(),
        title: Text("Home"),
        backgroundColor: kPrimaryColor,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        onPressed: () {
          Navigator.pushNamed(context, VideoCapture.routeName);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('Videos').snapshots(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return Text('');

                  case ConnectionState.waiting:
                    return ListView.separated(
                      itemCount: 5,
                      itemBuilder: (context, index) => NewsCardSkelton(),
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 16),
                    );

                  case ConnectionState.active:
                    return snapshot.hasData
                        ? ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data?.docs.length,
                            itemBuilder: (context, index) {
                              title = snapshot.data?.docs[index]["title"];
                              location = snapshot.data!.docs[index]["location"];
                              userName = snapshot.data!.docs[index]["userName"];
                              category = snapshot.data!.docs[index]["category"];
                              userPhotoURL =
                                  snapshot.data!.docs[index]["photoURL"];
                              return Column(
                                children: [
                                  VideoCard(
                                    onPressed: () {},
                                    category: category,
                                    size: size,
                                    title: title,
                                    location: location,
                                    userName: userName,
                                    photoURL: userPhotoURL,
                                    daysAgo: "5 days",
                                  ),
                                ],
                              );
                            },
                          )
                        : Container();
                  default:
                    {
                      return Center(
                        child: Text(
                          'No Data',
                        ),
                      );
                    }
                }
              },
              // child: Column(
              //   children: [
              //     ...List.generate(
              //       videoslist.length,
              //       (index) => Column(
              //         children: [
              //           VideoCard(
              //             size: size,
              //             category: videoslist[index].category,
              //             title: videoslist[index].title,
              //             location: videoslist[index].location,
              //             daysAgo: videoslist[index].daysAgo,
              //             userName: videoslist[index].userName,
              //             onPressed: () {
              //               Navigator.pushNamed(
              //                   context, VideoDetails.routeName);
              //             },
              //           ),
              //           SizedBox(height: size.height * 0.01),
              //         ],
              //       ),
              //     ),
              //   ],
              // ),
            ),
          ),
        ),
      ),
    );
  }
}

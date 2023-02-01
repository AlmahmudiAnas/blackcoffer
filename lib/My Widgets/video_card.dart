import 'package:flutter/material.dart';

class VideoCard extends StatelessWidget {
  VideoCard({
    super.key,
    required this.size,
    required this.category,
    required this.daysAgo,
    required this.location,
    required this.title,
    required this.userName,
    required this.onPressed,
    required this.photoURL
  });

  final Size size;
  String userName, daysAgo, title, location, category,photoURL;
  VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.1,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            spreadRadius: 1,
            blurRadius: 10,
            offset: Offset(0, 8), // changes position of shadow
          ),
        ],
      ),
      child: MaterialButton(
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(photoURL),
              ),
              SizedBox(width: size.width * 0.02),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title),
                  SizedBox(height: size.height * 0.02),
                  Row(
                    children: [
                      Text(userName),
                      SizedBox(width: size.width * 0.05),
                      Text(daysAgo),
                    ],
                  ),
                ],
              ),
              SizedBox(width: size.width * 0.05),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(location),
                  SizedBox(height: size.height * 0.02),
                  Text(category),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

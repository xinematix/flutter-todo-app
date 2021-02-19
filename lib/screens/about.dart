import 'package:flutter/material.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About Us"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Designed for easy task management',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              "Taskly manages a list of all your tasks to ensure that you're on track. ",
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'Contact',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              "Follow us on Facebook, Twitter and Instagram. Feel free to leave a feedback on any of our social media accounts.",
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              " \u00a9 2020 Taskly. All rights reserved ",
              style: TextStyle(fontSize: 16, color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

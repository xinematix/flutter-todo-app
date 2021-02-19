import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/screens/todo_app.dart';
import 'package:todo_app/screens/about.dart';
import 'package:todo_app/screens/profile.dart';
import 'package:todo_app/screens/dashboard.dart';
import 'package:todo_app/screens/setup/user_authentication.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatelessWidget {
  final Function onTap;
  final User user;
  MyDrawer({this.onTap, this.user});

  // User user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.deepPurple),
              child: Padding(
                padding: EdgeInsets.all(6),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 60,
                      height: 60,
                      child: CircleAvatar(
                        backgroundImage:
                            AssetImage('images/user-placeholder.png'),
                        // radius: 50,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      // 'Joey Lee',
                      verifyEmail(),
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    // Text(
                    //   'joey_lee@gmail.com',
                    //   style: TextStyle(fontSize: 12, color: Colors.white),
                    // ),
                  ],
                ),
              ),
            ),
            // ListTile(
            //   leading: Icon(Icons.home),
            //   title: Text('Home'),
            //   onTap: () => onTap(context, 0, 'Home'),
            // ),
            ListTile(
                leading: Icon(Icons.dashboard),
                title: Text('Dashboard'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Dashboard()));
                }),
            ListTile(
                leading: Icon(Icons.note),
                title: Text('My Tasks'),
                onTap: () {
                  // onTap(context, 0, "ToDoApp");
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ToDoApp()));
                }),
            ListTile(
                leading: Icon(Icons.info),
                title: Text('About'),
                onTap: () {
                  // onTap(context, 1, "About Taskly");
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => About()));
                }),
            ListTile(
                leading: Icon(Icons.person),
                title: Text('Profile'),
                onTap: () {
                  // onTap(context, 2, 'Profile');
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Profile()));
                }),

            ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Logout'),
                onTap: () {
                  context.read<UserAuthentication>().signOut();
                }),
          ],
        ),
      ),
    );
  }

  verifyEmail() {
    if (user == null) {
      return "Joey Lee";
    } else {
      return user.email;
    }
  }
}

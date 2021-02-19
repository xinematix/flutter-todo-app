import 'package:flutter/material.dart';
import 'package:todo_app/screens/setup/register_screen.dart';
import 'login_screen.dart';

class OpeningScreen extends StatefulWidget {
  OpeningScreen({Key key}) : super(key: key);

  @override
  _OpeningScreenState createState() => _OpeningScreenState();
}

class _OpeningScreenState extends State<OpeningScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //Login Button
            ButtonTheme(
              minWidth: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(10.0),
              child: RaisedButton(
                child: Text("Login",
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center),
                shape: StadiumBorder(side: BorderSide.none),
                color: Colors.white,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Login()));
                },
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            //Register Button
            ButtonTheme(
              minWidth: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(10.0),
              child: RaisedButton(
                child: Text(
                  "Register",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                shape: StadiumBorder(side: BorderSide.none),
                color: Colors.white,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Register()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

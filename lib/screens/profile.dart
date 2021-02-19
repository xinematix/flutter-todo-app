import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

var user = FirebaseAuth.instance.currentUser;
String _email, _password, _cfmPassword;
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController cfmPasswordController = TextEditingController();
final _formKey = GlobalKey<FormState>();

class Profile extends StatelessWidget {
  const Profile({Key key}) : super(key: key);
  // final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "User profile",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple),
                ),
                SizedBox(
                  height: 12,
                ),
                TextFormField(
                  initialValue: user.email ?? '',
                  onSaved: (input) => _email = input,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    // hintText: "Email",
                    hintText: user.email ?? '',
                    hintStyle: TextStyle(color: Colors.black, fontSize: 16),
                    fillColor: Colors.grey[300],
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                TextFormField(
                  obscureText: true,
                  validator: (input) {
                    if (input.length < 6) {
                      return 'Password must be more than 6 characters';
                    } else {
                      return null;
                    }
                  },
                  controller: passwordController,
                  onSaved: (input) => _password = input,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    hintText: "Change Password",
                    hintStyle: TextStyle(color: Colors.black, fontSize: 16),
                    fillColor: Colors.grey[300],
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                TextFormField(
                  obscureText: true,
                  onSaved: (input) => _cfmPassword = input,
                  validator: (input) {
                    if (input.isEmpty) {
                      return "Please confirm your password";
                    } else if (_cfmPassword != _password) {
                      // print("$_cfmPassword and $_password ");
                      print("$_cfmPassword and $_password ");
                      return "Passwords do not match.";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    hintText: "Confirm New Password",
                    hintStyle: TextStyle(color: Colors.black, fontSize: 16),
                    fillColor: Colors.grey[300],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ButtonTheme(
                  minWidth: MediaQuery.of(context).size.width,
                  child: RaisedButton(
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                      child: Text(
                        "Update Profile",
                        style: TextStyle(fontSize: 20),
                      ),
                      textColor: Colors.white,
                      color: Colors.indigo,
                      onPressed: () {
                        updateProfile();
                        Navigator.pop(context);
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> updateProfile() async {
  if (_formKey.currentState.validate()) {
    _formKey.currentState.save();
    try {
      await user.updatePassword(_password).then((_) {
        print("Successfully changed password");
      }).catchError((error) {
        print(error.toString());
      });
      await user.updateEmail(_email);
      // Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}

import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Register extends StatefulWidget {
  Register({Key key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  String _email, _password, _username, _cfmPassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Padding(
        padding: EdgeInsets.all(25),
        child: Form(
          key: _formKey,
          child: Container(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Registration",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  //email field
                  TextFormField(
                    validator: (input) {
                      if (input.isEmpty) {
                        return "Please enter an email address";
                      }
                    },
                    onSaved: (input) => _email = input,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.email,
                        color: Colors.white,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      hintText: "abc@email.com",
                      hintStyle: TextStyle(color: Colors.grey),
                      labelText: "Email",
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                  ),

                  //username field
                  TextFormField(
                    validator: (input) {
                      if (input.isEmpty) {
                        return "Please enter a username";
                      }
                    },
                    onSaved: (input) => _username = input,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      hintText: "jane doe",
                      hintStyle: TextStyle(color: Colors.grey),
                      labelText: "Username",
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                  ),

                  //password field
                  TextFormField(
                    validator: (input) {
                      if (input.isEmpty) {
                        return "Please enter a password";
                      } else if (input.length < 6) {
                        return "Password must be more than 6 characters";
                      } else {
                        return null;
                      }
                    },
                    onSaved: (input) => _password = input,
                    style: TextStyle(color: Colors.white),
                    obscureText: true,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.lock,
                        color: Colors.white,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      labelText: "Password",
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                  //confirm password
                  TextFormField(
                    validator: (input) {
                      if (input.isEmpty) {
                        return "Please confirm your password";
                      } else if (_cfmPassword != _password) {
                        return "Passwords do not match.";
                      } else {
                        return null;
                      }
                    },
                    style: TextStyle(color: Colors.white),
                    onSaved: (input) => _cfmPassword = input,
                    obscureText: true,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.lock,
                        color: Colors.white,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      labelText: "Confirm Password",
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  //submit button
                  ButtonTheme(
                    minWidth: 330,
                    padding: const EdgeInsets.all(10.0),
                    child: RaisedButton(
                      child: Text(
                        "Register",
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      shape: StadiumBorder(side: BorderSide.none),
                      color: Colors.white,
                      onPressed: signUp,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  //link to login page if user has an account
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Already have an account?",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      FlatButton(
                        child: Text(
                          "Log In",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.white,
                              fontSize: 15),
                        ),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Login()));
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signUp() async {
    if (_formKey.currentState.validate()) {
      //save form if its validated
      _formKey.currentState.save();
      try {
        User user = (await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _email,
          password: _password,
        ))
            .user;
        if (user != null) {
          setState(() {
            _email = user.email;
          });
        }
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Login()));
      } on FirebaseAuthException catch (e) {
        return e.message;
      }
    }
  }
}

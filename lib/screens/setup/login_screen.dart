import 'package:flutter/material.dart';
import 'register_screen.dart';
import '../todo_app.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String _email, _password;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //email field
              TextFormField(
                // controller: emailController,
                validator: (input) {
                  if (input.isEmpty) {
                    return "Please enter an email address";
                  } else
                    return null;
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
              SizedBox(
                height: 15,
              ),
              //password field
              TextFormField(
                // controller: passwordController,
                validator: (input) {
                  if (input.isEmpty) {
                    return "Please enter a password";
                  } else if (input.length < 6) {
                    return 'Password must be more than 6 characters';
                  } else {
                    return null;
                  }
                },
                onSaved: (input) => _password = input,
                obscureText: true,
                style: TextStyle(color: Colors.white),
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
              SizedBox(
                height: 30,
              ),
              //login button
              ButtonTheme(
                minWidth: 330,
                padding: const EdgeInsets.all(10.0),
                child: RaisedButton(
                  child: Text(
                    "Login",
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  shape: StadiumBorder(side: BorderSide.none),
                  color: Colors.white,
                  onPressed: signIn,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              //link to register page if user doesn't have an account
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  FlatButton(
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.white,
                          fontSize: 15),
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Register()));
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> signIn() async {
    if (_formKey.currentState.validate()) {
      //call onSaved functions to get email and password (?)
      _formKey.currentState.save();
      try {
        User user = (await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email,
          password: _password,
        ))
            .user;
        //create new doc for user with uid
        // await DatabaseService(uid: user.uid)
        //     .updateTodos('Complete Assignment', 'High', false);

        if (user != null) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ToDoApp(user: user)));
        }
      } on FirebaseAuthException catch (e) {
        return e.message;
      }
    }
  }
}

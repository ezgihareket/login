import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:login_page/homepage.dart';
import 'package:login_page/signup.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool isloggedin = true;
  bool _passwordVisible;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email, _password;

  checkUser() {
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    this.checkUser();
    _passwordVisible = false;
  }

  void login() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text;

    if (email.isNotEmpty && password.isNotEmpty) {
      _auth
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((user) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }).catchError((e) {
        showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                title: Text("ERROR"),
                content: Text("${e.message}"),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Cancel"),
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                  ),
                ],
              );
            });
      });
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: Text("ERROR"),
              content: Text("Please provide email and password"),
              actions: <Widget>[
                FlatButton(
                  child: Text("Cancel"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  child: Text("OK"),
                  onPressed: () {
                    _emailController.text = "";
                    _passwordController.text = "";
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Text("LOGIN",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple.shade700,
                      fontSize: 20,
                      height: 8)),
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 0, 40, 40),
                child: SvgPicture.asset("assets/img/login.svg"),
              ),
              Container(
                width: 350,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          color: Colors.deepPurple.shade100,
                          child: TextFormField(
                            controller: _emailController,
                            validator: (input) {
                              if (input.isEmpty) {
                                return "Enter Email";
                              }
                            },
                            decoration: InputDecoration(
                              labelText: "Email",
                              prefixIcon: Icon(
                                Icons.account_circle_rounded,
                                color: Colors.deepPurple.shade800,
                              ),
                              border: InputBorder.none,
                            ),
                            onSaved: (input) => _email = input,
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                      ),
                      SizedBox.fromSize(
                        size: Size(0, 20),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          color: Colors.deepPurple.shade100,
                          child: TextFormField(
                            obscureText: !_passwordVisible,
                            controller: _passwordController,
                            validator: (input) {
                              if (input.length < 6) {
                                return "Minimum 6 character";
                              }
                            },
                            decoration: InputDecoration(
                              labelText: "Password",
                              prefixIcon: Icon(
                                Icons.lock_rounded,
                                color: Colors.deepPurple.shade800,
                              ),
                              border: InputBorder.none,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.deepPurple.shade800,
                                ),
                                onPressed: () {
                                  // Update the state i.e. toogle the state of passwordVisible variable
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  });
                                },
                              ),
                            ),
                            //obscureText: true,
                            onSaved: (input) => _password = input,
                          ),
                        ),
                      ),
                      SizedBox.fromSize(
                        size: Size(0, 20),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: FlatButton(
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 60),
                          color: Colors.deepPurple.shade600,
                          onPressed: login,
                          child: Text(
                            "LOGIN",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox.fromSize(
                        size: Size(0, 10),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Don't Have a Account? ",
                            style: TextStyle(color: Colors.deepPurple.shade300),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUp()));
                            },
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                  color: Colors.deepPurple.shade600,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

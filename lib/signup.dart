import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:login_page/homepage.dart';
import 'package:login_page/login.dart';
import 'package:login_page/start.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email, _password, _name;

  checkUser() async {
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
  }

  signUp() async {
    final String emailTXT = _emailController.text.trim();
    final String passwordTXT = _passwordController.text;

    if (emailTXT.isNotEmpty && passwordTXT.isNotEmpty) {
      _auth
          .createUserWithEmailAndPassword(
              email: emailTXT, password: passwordTXT)
          .then((user) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Start()));
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
          builder: (ctx) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: Text("ERROR"),
              content: Text("Please provide email , password and name"),
              actions: <Widget>[
                FlatButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.of(ctx).pop();
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
              Text("SIGN UP",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple.shade700,
                      fontSize: 20,
                      height: 5)),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: SvgPicture.asset("assets/img/signup.svg"),
              ),
              Container(
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
                            controller: _nameController,
                            validator: (input) {
                              if (input.isEmpty) {
                                return "Enter Name";
                              }
                            },
                            decoration: InputDecoration(
                              labelText: "Name",
                              prefixIcon: Icon(
                                Icons.account_circle_rounded,
                                color: Colors.deepPurple.shade800,
                              ),
                              border: InputBorder.none,
                            ),
                            onSaved: (input) => _name = input,
                          ),
                        ),
                      ),
                      SizedBox.fromSize(
                        size: Size(0, 10),
                      ),
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
                                Icons.email_rounded,
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
                        size: Size(0, 10),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          color: Colors.deepPurple.shade100,
                          child: TextFormField(
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
                              suffixIcon: Icon(
                                Icons.visibility,
                                color: Colors.deepPurple.shade800,
                              ),
                            ),
                            obscureText: true,
                            onSaved: (input) => _password = input,
                          ),
                        ),
                      ),
                      SizedBox.fromSize(
                        size: Size(0, 30),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: FlatButton(
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 60),
                          color: Colors.deepPurple.shade600,
                          onPressed: signUp,
                          child: Text(
                            "SIGN UP",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox.fromSize(
                        size: Size(0, 20),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Already Have an Account? ",
                            style: TextStyle(color: Colors.deepPurple.shade300),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Login()));
                            },
                            child: Text(
                              "Sign In",
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

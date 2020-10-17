import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:login_page/start.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User user;
  bool isloggedin = false;

  checkUser() async {
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Start()));
      }
    });
  }

  getUser() async {
    User firebaseUser = await _auth.currentUser;
    await firebaseUser?.reload();
    firebaseUser = await _auth.currentUser;

    if (firebaseUser != null) {
      setState(() {
        this.user = firebaseUser;
        this.isloggedin = true;
      });
    }
  }

  signOut() async {
    _auth.signOut();
  }

  @override
  void initState() {
    this.checkUser();
    this.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: !isloggedin
            ? CircularProgressIndicator()
            : Column(
                children: <Widget>[
                  Text("WELCOME",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple.shade700,
                          fontSize: 20,
                          height: 5)),
                  Container(
                    padding: EdgeInsets.fromLTRB(40, 30, 30, 100),
                    child: SvgPicture.asset("assets/img/login.svg"),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 30),
                    child: Text(
                      "Hello ${user.displayName} you are logged in as ${user.email}",
                    ),
                  ),
                  SizedBox.fromSize(
                    size: Size(0, 140),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: FlatButton(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 60),
                      color: Colors.deepPurple.shade600,
                      onPressed: signOut,
                      child: Text(
                        "SIGN OUT",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

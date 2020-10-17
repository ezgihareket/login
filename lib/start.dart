import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:login_page/login.dart';
import 'package:login_page/signup.dart';

class Start extends StatefulWidget {
  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {
  navigateToLogin() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
  }

  navigateToSignUp() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 90, 20, 30),
              child: SvgPicture.asset("assets/img/chat.svg"),
            ),
            Container(
              width: 300,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: FlatButton(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  color: Colors.deepPurple.shade600,
                  onPressed: navigateToLogin,
                  child: Text(
                    "LOGIN",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 30),
              width: 300,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: FlatButton(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  color: Colors.black12,
                  onPressed: navigateToSignUp,
                  child: Text(
                    "SIGN UP",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

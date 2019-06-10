import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutterdemo/views/welcome_page/fourth_page.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() {
    // TODO: implement createState
    return new _WelcomePageState();
  }

}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return new Container(
        color: Colors.white,
        child: FourthPage()
    );
  }

}
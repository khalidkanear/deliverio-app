import 'package:flutter/scheduler.dart';

import '/Util/StartupUtility.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  TextEditingController baseAddress = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) => registrationStatus());

//    WidgetsBinding.instance.addPostFrameCallback((_) => registrationStatus());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldState,
      body: Center(
          child: SizedBox(
              height: 350,
              width: 350,
              child:
                  Image.asset("assets/images/logo.png", fit: BoxFit.fitWidth))),
    );
  }

  registrationStatus() async {
    nextScreen(_scaffoldState.currentContext!, _scaffoldState);
  }
}

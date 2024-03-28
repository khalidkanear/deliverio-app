import 'package:flutter/scheduler.dart';

import '/Components/flatTextButton.dart';
import '/Config.dart';
import '/Util/StartupUtility.dart';
import 'package:flutter/material.dart';

import '../../Constants.dart';

class SplashScreenTest extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreenTest> {
  TextEditingController baseAddress = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey();
  final GlobalKey<FormState> _form = GlobalKey();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) => registrationStatus());

    // WidgetsBinding.instance.addPostFrameCallback((_) => registrationStatus());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldState,
        body: Padding(
          padding: EdgeInsets.all(kDefaultPadding * 2),
          child: Column(
            children: [
              Form(
                key: _form,
                child: TextFormField(
                  controller: baseAddress,
                  validator: (value) {
                    if ('$value'.isEmpty) {
                      return "Please Enter Base Url";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      labelText: "Base Url",
                      labelStyle: TextStyle(
                          fontSize: SizeConfig.heightMultiplier * 2.2)),
                ),
              ),
              SizedBox(
                height: kDefaultPadding * 2,
              ),
              InkWell(
                  onTap: () {
                    if (_form.currentState!.validate()) {
                      baseUrl = baseAddress.text;
                      registrationStatus();
                    }
                  },
                  child: FlatTextButton(
                      context, "Proceed", double.infinity, kOrange))
            ],
          ),
        ));
  }

  registrationStatus() async {
    nextScreen(_scaffoldState.currentContext!, _scaffoldState);
  }
}

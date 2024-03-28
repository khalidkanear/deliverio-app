import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Config.dart';
import '../Constants.dart';

Widget locationDialog(GlobalKey<ScaffoldState> key) {
  return AlertDialog(
    elevation: 0,
    insetPadding: EdgeInsets.symmetric(
        horizontal: SizeConfig.heightMultiplier * 2,
        vertical: kDefaultPadding * 2),
    contentPadding: const EdgeInsets.all(0),
    backgroundColor: Colors.transparent,
    content: Container(
      decoration: circularEdges(20, 20, 20, 20, Colors.white),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: SizeConfig.heightMultiplier * 2,
          ),
          Icon(
            Icons.location_on_outlined,
            color: Colors.black,
            size: SizeConfig.heightMultiplier * 4,
          ),
          const Text(
            "Location Access",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          Container(
            padding: EdgeInsets.all(kDefaultPadding),
            child: Text(
              "Please grant access to Background Location in order to start receiving orders placed by the customers even if the app is in background.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: SizeConfig.heightMultiplier * 2),
            ),
          ),
          InkWell(
            onTap: () async {
              SharedPreferences pref = await SharedPreferences.getInstance();

              pref.setBool("locDialog", true);

              Navigator.of(key.currentContext!).pop();
            },
            child: Container(
              padding: EdgeInsets.all(kDefaultPadding),
              child: Text(
                "Allow access",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: SizeConfig.heightMultiplier * 2.5,
                    color: Colors.blueAccent),
              ),
            ),
          ),
          SizedBox(
            height: SizeConfig.heightMultiplier * 2,
          )
        ],
      ),
    ),
  );
}

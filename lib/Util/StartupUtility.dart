import 'dart:convert';
import '/Components/SnackBar.dart';
import '/Screens/HomeScreen/Models/GetLocationUtil.dart';
import '/Screens/HomeScreen/Models/StatusProvider.dart';
import '/Screens/Welcome/Welcome.dart';
import '/WebServices/GetStatusOnline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Constants.dart';

void nextScreen(BuildContext context, GlobalKey<ScaffoldState> key) async {
  SharedPreferences pref = await SharedPreferences.getInstance();

  //_pref.clear();
  String? profileRaw = pref.getString("userProfile");

  riderId = pref.getString("riderId");

  String route = '/home';

  ///Check if user exists
  ///Check if user exists
  ///Check if user exists
  if (riderId != null) {
    if (profileRaw != null) {
      bearerToken = jsonDecode(profileRaw)["bearerToken"];
      fullName = jsonDecode(profileRaw)["fullName"];
    }

    Id = jsonDecode(profileRaw.toString())["userName"];

    print("Splash Screen 2  : $profileRaw");

    //_pref.remove("orderDetails");
    bool? onlineStatus = pref.getBool("OnlineStatus");
    String ?orderDetails = pref.getString("orderDetails");
    orderId = pref.getString("orderId");

    if (onlineStatus != null) {
      Provider.of<Status>(context, listen: false).updateStatus(onlineStatus);
      statusOnline = onlineStatus;
    }

    ///++++++++++++++++++++++++++++++++++++++++++++++++++++=
    ///++++++++++++++++++++++++++++++++++++++++++++++++++++=

    ///Check if an order is ongoing
    ///Check if an order is ongoing
    ///Check if an order is ongoing
    if (orderDetails != null) {
      orderDetailGlobal = orderDetails;
      print(orderDetails);

      await GetLocaiton().getPermissions(key);

      route = '/orderInitiated';
    }

    ///++++++++++++++++++++++++++++
    ///++++++++++++++++++++++++++++
    ///++++++++++++++++++++++++++++

    ///++++++++++++++++++ Get Online Status +++++++++=
    ///++++++++++++++++++ Get Online Status +++++++++=
    ///++++++++++++++++++ Get Online Status +++++++++=
    ///++++++++++++++++++ Get Online Status +++++++++=

    Map<String, dynamic> online_Status =
        await getStatusOnlineReq(int.parse(riderId.toString()));

    if (onlineStatus == null) {
      Navigator.pushReplacementNamed(context, '/error');
    } else if (online_Status["status"] == 200 || online_Status["status"] == 201) {
      statusOnline = online_Status["response"];

      pref.setBool("OnlineStatus", statusOnline);

      Provider.of<Status>(context, listen: false).updateStatus(statusOnline);

      Navigator.pushReplacementNamed(context, route);
    } else if (online_Status["status"] == 101) {
      Navigator.pushReplacementNamed(context, '/noConnection');
    } else if (online_Status["status"] == 401) {
      showSnackBar("Session Expired", key);
      pref.clear();
      Navigator.pushNamed(context, '/login');
      // To-Do
    } else {
      //showSnackBar(onlineStatus["response"], _key);
      Navigator.pushReplacementNamed(context, '/error');
    }

    ///=============================================
    ///=============================================
    ///=============================================
    ///=============================================
    ///=============================================

  } else {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => Welcome(),
        transitionDuration: const Duration(seconds: 0),
      ),
    );
  }

  getStatusOnline() async {}
}

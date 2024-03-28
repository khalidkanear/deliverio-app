import 'dart:async';
import '/Components/LocationDialog.dart';
import '/Constants.dart';
import '/Screens/HomeScreen/Models/StatusProvider.dart';
import '/WebServices/UpdateLocation.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetLocaiton {
  static LocationData _lastLocation=LocationData as LocationData;

  static Future<bool> hasPermission(GlobalKey<ScaffoldState> key) async {
    Location location = Location();
    bool serviceEnabled;

    serviceEnabled = await location.serviceEnabled();

    if (serviceEnabled) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> getLocation(GlobalKey<ScaffoldState> key) async {
    //Current Location
    //Current Location
    Location location = Location();
    PermissionStatus permissionGranted;
    bool serviceEnabled;

    SharedPreferences pref = await SharedPreferences.getInstance();

    bool? dialog = pref.getBool("locDialog");

    if (dialog == null) {
      await showDialog(
          context: key.currentContext!,
          builder: (BuildContext context) {
            return locationDialog(key);
          });
    }

    serviceEnabled = await location.serviceEnabled();

    if (!serviceEnabled) {
      Navigator.pushReplacementNamed(key.currentContext!, "/locationError");
      //_serviceEnabled = await location.requestService();

      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();

    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();

      if (permissionGranted != PermissionStatus.granted) {
        return;
      } else {
        pref.setBool("locDialog", true);
      }
    }

    _lastLocation = await location.getLocation();

    Provider.of<Status>(key.currentContext!, listen: false)
        .updateCurrentPosition(_lastLocation);

    currentLoc = "${_lastLocation.latitude},${_lastLocation.longitude}";

    Map<String, dynamic> resUpdateLoc = await UpdateLocation(
            lat: _lastLocation.latitude.toString(),
            long: _lastLocation.longitude.toString())
        .updateReq();
    //Map<String,dynamic> _resUpdateLoc = await UpdateLocation(lat: "4.1947928",long: "103.435782").updateReq();
    print("Loc Update Response 1 : $resUpdateLoc");

    ///Location Updates
    ///Location Updates
    ///Location Updates
    location.onLocationChanged.listen((LocationData currentLocation) async {
      print(currentLocation.latitude);
      print(currentLocation.longitude);

      int latOld = int.parse(
          _lastLocation.latitude.toString().split(".")[1].substring(3, 4));
      int longOld = int.parse(
          _lastLocation.longitude.toString().split(".")[1].substring(3, 4));
      int latCurrent = int.parse(
          currentLocation.latitude.toString().split(".")[1].substring(3, 4));
      int longCurrent = int.parse(
          currentLocation.longitude.toString().split(".")[1].substring(3, 4));

      if (latOld != latCurrent || longOld != longCurrent) {
        _lastLocation = currentLocation;

        currentLoc = "${_lastLocation.latitude},${_lastLocation.longitude}";

        Map<String, dynamic> resUpdateLoc = await UpdateLocation(
                lat: currentLocation.latitude.toString(),
                long: currentLocation.longitude.toString())
            .updateReq();

        print("Loc Update Response : $resUpdateLoc");
        //showSnackBar(_resUpdateLoc.toString() + " : " +currentLocation.longitude.toString(), _key);

      }
    });
  }

  Future<LocationData?> getPermissions(GlobalKey<ScaffoldState> key) async {
    Location location = Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();

      if (!serviceEnabled) {
        return null;
      }
    }

    permissionGranted = await location.hasPermission();

    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    _lastLocation = await location.getLocation();
    currentLoc = "${_lastLocation.latitude},${_lastLocation.longitude}";

    return _lastLocation;
  }
}

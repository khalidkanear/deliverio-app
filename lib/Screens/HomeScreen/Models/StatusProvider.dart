import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class Status extends ChangeNotifier{

  CameraPosition? currentPosition;
  bool locationLoaded = false;
  bool status = false;

  updateStatus(bool val){

    status = val;
    notifyListeners();

  }


  updateCurrentPosition(LocationData? location){

    currentPosition = CameraPosition(
      target: LatLng(location?.latitude??0.0,location?.longitude??0.0),
      zoom: 15,
    );
    locationLoaded = true;
    notifyListeners();
  }

}
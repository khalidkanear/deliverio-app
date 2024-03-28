import 'package:flutter/cupertino.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../Constants.dart';

class MapChangeListener extends ChangeNotifier {
  // this set will hold my markers
  Set<Marker> markers = {};
// this will hold the generated polylines
  Set<Polyline> polylines = {};
// this will hold each polyline coordinate as Lat and Lng pairs
  List<LatLng> polylineCoordinates = [];
// this is the key object - the PolylinePoints
// which generates every polyline between start and finish
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPIKey = "AIzaSyCWNzaOBOMYoeaxzhgDrUWFq_rISR5ZAmo";

  bool showList = false;

  void resetAll() {
    markers = {};
    polylines = {};
    polylineCoordinates = [];
    polylinePoints = PolylinePoints();
    notifyListeners();
  }

  void setMapPins(LatLng pickup, LatLng delivery) {
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(1, 1)), 'assets/images/pickupPin.png')
        .then((onValue) {
      markers.add(Marker(
        markerId: const MarkerId("source"),
        position: pickup,
        icon: onValue,
      ));
    });

    BitmapDescriptor.fromAssetImage(const ImageConfiguration(size: Size(1, 1)),
            'assets/images/dropOffPin.png')
        .then((onValue) {
      markers.add(Marker(
          markerId: const MarkerId("destination"),
          position: delivery,
          icon: onValue));
    });

    notifyListeners();
  }

  setPolylines(PointLatLng origin, String stop, PointLatLng destination) async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleAPIKey, origin, destination,
        wayPoints: [PolylineWayPoint(location: stop)]);

    if (result.points.isNotEmpty) {
      // loop through all PointLatLng points and convert them
      // to a list of LatLng, required by the Polyline
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }

    // create a Polyline instance
    // with an id, an RGB color and the list of LatLng pairs
    Polyline polyline = Polyline(
      width: 5,
      polylineId: const PolylineId("Poly"),
      color: kBase,
      points: polylineCoordinates,
    );

    // add the constructed polyline as a set of points
    // to the polyline set, which will eventually
    // end up showing up on the map
    polylines.add(polyline);
    notifyListeners();

    Future.delayed(const Duration(milliseconds: 300), () {
      showList = true;
      notifyListeners();
    });
  }
}

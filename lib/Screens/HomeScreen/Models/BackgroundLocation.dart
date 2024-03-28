import 'package:background_location/background_location.dart';
import 'package:background_locator/background_locator.dart';
import 'package:permission_handler/permission_handler.dart';

class BackLocService {
  getBgLocation() async {
    BackgroundLocator.updateNotificationText(
        title: "Location Access",
        msg: "OneDelivery is accessing your current Location",
        bigMsg: "");
    BackgroundLocation.setAndroidNotification(
      title: "Location Access",
      message: "OneDelivery is accessing your current Location",
      icon: "@mipmap/bg_location",
    );

    var permission = await Permission.locationAlways.isGranted;

    if (!permission) {
      var permission = await Permission.locationAlways.request();

      if (permission.isGranted) {
        BackgroundLocator.initialize();
        BackgroundLocation.startLocationService();

        BackgroundLocation.getLocationUpdates((location) {
          print("${location.longitude},${location.longitude}");
        });
      }
    } else if (permission) {
      BackgroundLocation.startLocationService();

      BackgroundLocation.getLocationUpdates((location) {
        print("${location.longitude},${location.longitude}");
      });
    }
  }

  stopService() {
    BackgroundLocation.stopLocationService();
  }
}

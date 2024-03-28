import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

import '/Components/OrderAlert.dart';
import '/Components/SnackBar.dart';
import '/Screens/HomeScreen/Components/Drawer.dart';
import '/Screens/HomeScreen/Models/GetLocationUtil.dart';
import '/Screens/HomeScreen/Models/OrderAlert.dart';
import '/Screens/HomeScreen/Models/StatusProvider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibration/vibration.dart';
import '../../../Config.dart';
import '../../../Constants.dart';
import '../../../string.dart';
import 'AppBarHome.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

/// ORDER ALERT
/// ORDER ALERT
/// ORDER ALERT
_showDialog(BuildContext context, OrderAlertModel order) {
  Vibration.vibrate(
    pattern: [500, 1000, 500, 1000, 500, 1000, 500, 500, 100],
    intensities: [128, 255, 64, 255, 30, 100, 200, 150, 255],
  );

  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext dialogContext) {
        return WillPopScope(
            onWillPop: () {
              return Future.delayed(const Duration(milliseconds: 10), () => false);
            },
            child: buildOrderAlert(dialogContext, order));
      });
}

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class _HomeState extends State<Home> {
  static const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('app_icon');

  final InitializationSettings initializationSettings =
      const InitializationSettings(android: initializationSettingsAndroid);

  final Completer<GoogleMapController> _controller = Completer();

  BuildContext? c;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      configureFirebaseMessaging();
      GetLocaiton().getLocation(_scaffoldKey);
      getNotification();
      statusUpdate();
    });
  }

  getNotification() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    orderId = pref.getString("orderId");
    String ?sentAt = pref.getString("SentAt");
    String? title = pref.getString("Title");

    print('$orderId ' "++++++++++++++++++++ A");

    OrderAlertModel order = OrderAlertModel(
      franchiseAddress: pref.getString("franchiseAddress"),
      franchiseName: pref.getString("franchiseName"),
      deliveryAddress: pref.getString("deliveryAddress"),
      pickTime: pref.getString("pickTime"),
      deliveryFee: pref.getString("deliveryFee"),
      profileImageFranchise: pref.getString("profileImageFranchise"),
    );

    print("$order++++++++++++++++++++");

    if (orderId != null) {
      bool check = await newOrderCheck(sentAt.toString());

      if (title == "New Order" && check) {
        orderInQueue = true;

        _showDialog(_scaffoldKey.currentContext!, order);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      key: _scaffoldKey,

      ///Navigation Drawer
      ///Navigation Drawer
      drawer: drawer(context),

      ///AppBar
      ///AppBar
      appBar: buildAppBarHome(context, _scaffoldKey),

      ///BOdy
      ///BOdy
      ///BOdy
      body: Container(
          decoration: circularEdges(0, 0, 20, 20, Colors.white),
          height: SizeConfig.heightMultiplier * 100,
          width: SizeConfig.imageSizeMultiplier * 100,
          child: Consumer<Status>(
            builder: (context, item, child) {
              return Column(
                children: [
                  /// GOOGLE MAP
                  /// GOOGLE MAP
                  /// GOOGLE MAP
                  Expanded(
                    flex: 9,
                    child: Container(
                      padding: item.status
                          ? const EdgeInsets.all(0)
                          : EdgeInsets.all(SizeConfig.heightMultiplier * 4),
                      child: item.status
                          ? !item.locationLoaded
                              ? Center(
                                  child: CircularProgressIndicator(
                                    backgroundColor: kGreen,
                                    color: kBaseLight,
                                  ),
                                )
                              : GoogleMap(
                                  zoomControlsEnabled: false,
                                  compassEnabled: true,
                                  myLocationButtonEnabled: true,
                                  myLocationEnabled: true,
                                  mapType: MapType.normal,
                                  initialCameraPosition: item.currentPosition??const CameraPosition(target: LatLng(0.0,0.0)),
                                  onMapCreated:
                                      (GoogleMapController controller) {
                                    _controller.complete(controller);
                                  },
                                )
                          : Center(
                              child: Text(
                                english
                                    ? "Go online and start picking up Orders"
                                    : m["Go online and start picking up Orders"].toString(),
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.headline2,
                              ),
                            ),
                    ),
                  ),
                ],
              );
            },
          )),
    );
  }

  void configureFirebaseMessaging() async {
    await Firebase.initializeApp();

    //await flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: (hello)async{ print(hello);});

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage ? message) async {
      RemoteMessage? message = messageG;
      print("A : $message");

      if (message != null) {
        bool check = await newOrderCheck(message.data["SentAt"]);

        if (message.data["Title"] == "New Order" && check && !orderInQueue) {
          orderInQueue = true;
          //_showDialog(_scaffoldKey.currentContext , _makeOrder( message ) );

          if (getTimeDifferenceInSeconds(message) > 25) {
            showSnackBar(
                english
                    ? "Sorry, you missed this order"
                    : "Maaf, Anda Terlepas Pesanan Ini",
                _scaffoldKey);
          } else {
            _showDialog(_scaffoldKey.currentContext!, _makeOrder(message));
          }
        }
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print("B : $message");

      bool check = await newOrderCheck(message.messageId.toString());

      print(!orderInQueue);

      if (message.data["Title"] == "New Order" && check) {
        orderInQueue = true;

        //_showDialog(_scaffoldKey.currentContext , _makeOrder( message ) );

        if (getTimeDifferenceInSeconds(message) > 25 && check) {
          print(getTimeDifferenceInSeconds(message));
          showSnackBar(
              english
                  ? "Sorry, you missed this order"
                  : "Maaf, Anda Terlepas Pesanan Ini",
              _scaffoldKey);
        } else {
          _showDialog(_scaffoldKey.currentContext!, _makeOrder(message));
        }
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print("onMessage C: $message");

      bool check = await newOrderCheck(message.data["SentAt"]);

      if (message.data["Title"] == "New Order" && check) {
        orderInQueue = true;
        //_showDialog(_scaffoldKey.currentContext , _makeOrder( message ) );

        if (getTimeDifferenceInSeconds(message) > 45) {
          showSnackBar(
              english
                  ? "Sorry, you missed this order"
                  : "Maaf, Anda Terlepas Pesanan Ini",
              _scaffoldKey);
        } else {
          _showDialog(_scaffoldKey.currentContext!, _makeOrder(message));
        }
      }
    });
  }
}

void statusUpdate() {
  FirebaseFirestore.instance
      .collection("OnlineStatus")
      .doc("03204100904")
      .snapshots(includeMetadataChanges: true)
      .listen((snapshot) {
    Provider.of<Status>(_scaffoldKey.currentContext!, listen: false)
        .updateStatus(snapshot.data()!["status"]);
  });
}

//FirebaseMessaging.onBackgroundMessage((message)=>_backgroundMessageHandler(message));

OrderAlertModel _makeOrder(RemoteMessage message) {
  orderId = message.data["OrderId"];

  print("Home Screen : OrderID$orderId");
  print("Home Screen : RiderID$riderId");

  OrderAlertModel order = OrderAlertModel(
      franchiseAddress: message.data["Franchise_Address"],
      franchiseName: message.data["Franchise_Name"],
      deliveryAddress: message.data["Delivery_Address"],
      pickTime: message.data["OrderPickupTime"].toString().replaceAll("T", " "),
      deliveryFee: message.data["DeliveryFee"],
      profileImageFranchise:
          "https://play-lh.googleusercontent.com/9YewoWlnPknIUYPg9eCt37NNu0opdGMJAqQakcPLQONWXaBhocXcrDL8UPUEXqPytyE");

  return order;
}

int getTimeDifferenceInSeconds(RemoteMessage message) {
  try {
    DateTime ?sentTime = message.sentTime;

    DateTime current = DateTime.now();

    return current.difference(sentTime!).inSeconds;
  } on Exception catch (error) {
    print(error);
    return 20;
  }
}

Future<bool> newOrderCheck(String msgId) async {
  SharedPreferences pref = await SharedPreferences.getInstance();

  String ? lastNotification = pref.getString("msgId");

  if (lastNotification == msgId) {
    return false;
  } else {
    pref.setString("msgId", msgId);
    return true;
  }
}

Future<void> backgroundMessageHandler(RemoteMessage message) async {
  print("object+++++++++++++++++++++++++++++++++");

  SharedPreferences pref = await SharedPreferences.getInstance();

  pref.setString("SentAt", message.data["SentAt"]);
  pref.setString("Title", message.data["Title"]);

  pref.setString("franchiseAddress", message.data["Franchise_Address"]);
  pref.setString("franchiseName", message.data["Franchise_Name"]);
  pref.setString("deliveryAddress", message.data["Delivery_Address"]);
  pref.setString("pickTime",
      message.data["OrderPickupTime"].toString().replaceAll("T", " "));
  pref.setString("deliveryFee", message.data["DeliveryFee"]);
  pref.setString("profileImageFranchise",
      "https://play-lh.googleusercontent.com/9YewoWlnPknIUYPg9eCt37NNu0opdGMJAqQakcPLQONWXaBhocXcrDL8UPUEXqPytyE");
  pref.setString("profileImageFranchise",
      "https://play-lh.googleusercontent.com/9YewoWlnPknIUYPg9eCt37NNu0opdGMJAqQakcPLQONWXaBhocXcrDL8UPUEXqPytyE");
  pref.setString("orderId", message.data["OrderId"]);

  messageG = message;
}

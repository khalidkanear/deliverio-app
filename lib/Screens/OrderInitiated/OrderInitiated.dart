import 'dart:async';
import 'dart:convert';
import '/Components/CloseAppDialog.dart';
import '/Screens/DragableList/dragableSheet.dart';
import '/Constants.dart';
import '/Screens/OrderInitiated/Model/CustomerDetails.dart';
import '/Screens/OrderInitiated/Model/MapChangeListener.dart';
import '/Screens/OrderInitiated/Model/MerchantDetails.dart';
import '/Screens/OrderInitiated/Model/OrderDetailsModel.dart';
import '/Screens/OrderInitiated/Model/OrderItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../Config.dart';


class OrderInitiated extends StatelessWidget {



   final Map<String, dynamic > _orderJson = jsonDecode(orderDetailGlobal);



  OrderDetails? _order;

   OrderInitiated( ) {

    totalBill = _orderJson["totalBill"];


    CustomerDetails customerDetails = CustomerDetails(

      name: _orderJson["customerName"],
      phoneNo: _orderJson["customerPhone"],
      address: _orderJson["deliveryAddress"],
      lat: _orderJson["deliveryLat"],
      long: _orderJson["deliveryLng"]

    );

    MerchantDetails merchantDetails = MerchantDetails(
      name: _orderJson["franchiseName"],
      phoneNo: _orderJson["franchisePhone"],
      address: _orderJson["franchiseAddress"],
      lat: _orderJson["franchiseLat"],
      long: _orderJson["franchiseLng"],


    );

    List<dynamic> productsTemp = _orderJson["products"];

    List<OrderItem> productList = [];




    for(int i = 0; i < productsTemp.length ; i++){


      OrderItem product =  OrderItem(

        name: _orderJson["products"][i]["name"],
        sku: _orderJson["products"][i]["sku"],
        price: _orderJson["products"][i]["price"],
        quantity: _orderJson["products"][i]["quantity"],
        description: _orderJson["products"][i]["description"],
        store: _orderJson["franchiseName"]



      );

      productList.add(product);


    }

    _order = OrderDetails(

      refNo: _orderJson["refNo"],
      timePickup: "${_orderJson["orderPickupTime"].toString().replaceAll("T", " ").split(".")[0]} minutes",
      timeDelivery: _orderJson["deliveryTime"].toString().replaceAll("T", " ").split(".")[0],
      orderNumber: orderId,
      total: _orderJson["totalBill"],
      customerDetails: customerDetails,
      merchantDetails: merchantDetails,
      orderItems: productList



    );

  }


  final GlobalKey<ScaffoldState> _key = GlobalKey();



  final Completer<GoogleMapController> _controller = Completer();


   final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(3.1390, 101.6869),
    zoom: 13,
  );




  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _key,
      backgroundColor: Colors.white,
      body: WillPopScope(
        ///EXIT APPLICATION
        ///EXIT APPLICATION
        ///EXIT APPLICATION
        onWillPop: () async {

          showDialog(context: context, builder: (BuildContext context){
            return closeAppDialog(context);
          });

          return false;

        },

        child: Consumer<MapChangeListener>(
            builder:(context, item , child){
              return  Stack(
                alignment: Alignment.bottomCenter,
                children: [

                  //SizedBox(height: kDefaultPadding * 2 ,),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 96.5,
                    child: GoogleMap(
                      buildingsEnabled: false,
                      padding: EdgeInsets.symmetric(vertical: kDefaultPadding * 2, horizontal: kDefaultPadding),
                      polylines: item.polylines,
                      markers: item.markers,
                      compassEnabled: true,
                      myLocationEnabled: true,
                      mapType: MapType.normal,
                      initialCameraPosition: _kGooglePlex,
                      onMapCreated: (GoogleMapController controller) async {
                        _controller.complete(controller);



                        Provider.of<MapChangeListener>(context,listen: false).setPolylines(
                            PointLatLng(double.parse(currentLoc.split(",")[0]), double.parse(currentLoc.split(",")[1]) ) ,
                            '${_order?.merchantDetails?.lat}'","'${_order?.merchantDetails?.long}',
                            PointLatLng(double.parse('${_order?.customerDetails?.lat}'), double.parse('${_order?.customerDetails?.long}') )
                        );

                        Provider.of<MapChangeListener>(context,listen: false)
                            .setMapPins(
                            LatLng(double.parse('${_order?.merchantDetails?.lat}'), double.parse('${_order?.merchantDetails?.long}')),
                            LatLng(double.parse('${_order?.customerDetails?.lat}'),  double.parse('${_order?.customerDetails?.long}'))
                        );
                      },
                    ),
                  ),

                  item.showList ? DragableList(orderDetails: _order,key: _key,) : Container()





                ],
              );
            }
        ),
      )
    );





  }

}

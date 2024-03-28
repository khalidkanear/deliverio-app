import 'dart:convert';
import '/Components/AppBar.dart';
import '/Components/SnackBar.dart';
import '/Constants.dart';
import '/Model/CompletedOrders.dart';
import '/Screens/OrderInitiated/Model/CustomerDetails.dart';
import '/Screens/OrderInitiated/Model/MerchantDetails.dart';
import '/Screens/OrderInitiated/Model/OrderDetailsModel.dart';
import '/Screens/OrderInitiated/Model/OrderItem.dart';
import '/Screens/Orders/Models/OrdersListener.dart';
import '/WebServices/GetOrdersList.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../string.dart';
import 'Components/GroupedOrderList.dart';






class Orders extends StatefulWidget {




  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {

  _OrdersState(){
    getOrdersList();
  }


  final List<OrderDetails> _orders = [];

  bool loading = true;

  final List _elements = [];


  bool error = false;

  final RefreshController _refreshController = RefreshController(initialRefresh: false);


  void _onRefresh() async{
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 10));
    getOrdersList();
    _refreshController.refreshCompleted();
  }


  String errorMessage = "Something went wrong";

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      key: _key,
      backgroundColor: Colors.white,
      appBar: appBar(english ? "Orders" : m["Orders"], context,  Colors.white, Colors.black),

      body: loading ? Center(child: CircularProgressIndicator(backgroundColor: kGreen, color: kBaseLight,),) :

      error ? SmartRefresher(
          onRefresh: _onRefresh,
          controller: _refreshController,

          child: Center(child: Text(errorMessage , style: Theme.of(context).textTheme.headline2,),)) :

          _orders.isEmpty ? Center(child: Text("No Orders yet.", style: Theme.of(context).textTheme.headline2,),)  :


              Consumer<OrdersListener>(

              builder:(context,item, child){

                return GroupedList(context: context, orders: _elements,);

              }),

    );


  }







  getOrdersList() async {

    Map<String ,dynamic > responseGetOrderList = await getAllOrdersByRider();
    //Map<String ,dynamic > responseGetOrderList = {"status":200,"response":ordertemp};

    print(responseGetOrderList);

    if(responseGetOrderList["status"]== 200){

      _orders.clear();
      _elements.clear();
      Provider.of<CompletedOrdersProvider>(_key.currentContext!,listen: false).reset();


      List<dynamic> ordersList = jsonDecode(responseGetOrderList["response"]);




      for (var order in ordersList) {

        List<dynamic> orderItems = order["products"];
        List<OrderItem> orderItemList = [];

        for (var item in orderItems) {

          orderItemList.add(
              OrderItem(
                name: item["name"],
                description: item["description"],
                sku: item["sku"],
                price: item["price"],
                quantity: item["quantity"],
                store: order["franchiseName"],

              )
          );

        }


        _orders.add(  OrderDetails(

            distance: order["estTravelDistance"].toString(),
            timeDelivery: order["deliveryTime"].toString().replaceAll("T", " ").split(".")[0],
            orderNumber: order["refNo"],
            total: order["totalBill"],
            refNo: order["refNo"],
            orderItems: orderItemList,

            customerDetails: CustomerDetails(

              address: order["deliveryAddress"],

            ),

            merchantDetails: MerchantDetails(

              name: order["franchiseName"],
              address: order["franchiseAddress"],

            ), timePickup: ''


        ));


      }

      for (var order in _orders) {

        String? month = order.timeDelivery?.split("-")[1];
        if(month?.substring(0,1) == '0'){

          month = month?.substring(1,2);
        }


        _elements.add(
            {
              "group": month,
              "order":order
            }
        );


        print(_elements);





      }


      Future.delayed(
          const Duration(seconds: 1),(){
            Provider.of<CompletedOrdersProvider>(_key.currentContext!,listen: false).updateList(_orders,DateTime.now().month);
      });

      setState(() {
        error = false;
        loading = false;
      });


    }else{

      error = true;
      loading = false;
      errorMessage = english ? "No internet" : m["No internet"].toString();
      setState(() {

      });
      showSnackBar(english ? "Something went wrong, please try again later" : m["Something went wrong, please try again later"].toString(), _key);
    }

  }
}

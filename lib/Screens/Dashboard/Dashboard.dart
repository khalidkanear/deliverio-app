import 'dart:convert';
import '/Components/SnackBar.dart';
import '/Components/dialogWithList.dart';
import '/Config.dart';
import '/Model/CompletedOrders.dart';
import '/Screens/Dashboard/Models/GraphOrders.dart';
import '/Screens/OrderInitiated/Model/CustomerDetails.dart';
import '/Screens/OrderInitiated/Model/MerchantDetails.dart';
import '/Screens/OrderInitiated/Model/OrderDetailsModel.dart';
import '/Screens/OrderInitiated/Model/OrderItem.dart';
import '/WebServices/GetOrdersList.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../Constants.dart';
import '../../string.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  _DashboardState() {
    getOrdersList();
  }

  bool _loaded = false;

  bool error = false;

  String errorMessage = "Something went wrong  :(";

  final List<OrderDetails> _orders = [];

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  List<String> months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];

  String? toMonth(int month) {
    switch (month) {
      case 1:
        return "January";
        break;

      case 2:
        return "February";
        break;

      case 3:
        return "March";
        break;

      case 4:
        return "April";
        break;

      case 5:
        return "May";
        break;

      case 6:
        return "June";
        break;

      case 7:
        return "July";
        break;

      case 8:
        return "August";
        break;

      case 9:
        return "September";
        break;

      case 10:
        return "October";
        break;

      case 11:
        return "November";
        break;

      case 12:
        return "December";
        break;
    }
    return null;
  }

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 10));
    getOrdersList();
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _key,
        appBar: AppBar(
          elevation: 0,
          leading: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: const Icon(Icons.arrow_back_ios),
          ),
          title: Text(
            english ? "Dashboard" : m["Dashboard"].toString(),
            style: Theme.of(context)
                .textTheme
                .headline2
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          backgroundColor: kGrey,
          iconTheme: const IconThemeData(color: Colors.black),
          actions: [
            InkWell(
              onTap: () => _showDialog(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Consumer<CompletedOrdersProvider>(
                      builder: (context, orderList, child) {
                    return Text(
                      toMonth(orderList.selectedMonth).toString(),
                      style: Theme.of(context).textTheme.headline2?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent),
                    );
                  }),
                  SizedBox(
                    width: kDefaultPadding,
                  )
                ],
              ),
            )
          ],
        ),
        backgroundColor: kGrey,
        body: Consumer<CompletedOrdersProvider>(
          builder: (context, orderList, child) {
            return _loaded
                ? error
                    ? SmartRefresher(
                        onRefresh: _onRefresh,
                        controller: _refreshController,
                        enablePullDown: true,
                        child: Center(
                            child: Text(
                          errorMessage,
                          style: TextStyle(
                              fontSize: SizeConfig.heightMultiplier * 2.0),
                        )),
                      )
                    : orderList.spots.isNotEmpty
                        ? Column(
                            children: [
                              Expanded(
                                flex: 5,
                                child: Container(),
                              ),

                              /*Expanded(
                  flex: 15,
                  child:Stack(
                    children: [
                      Container(
                        height: double.infinity,
                        width: SizeConfig.imageSizeMultiplier * 100,
                        margin: EdgeInsets.only(top: kDefaultPadding , bottom: kDefaultPadding , left : kDefaultPadding * 2, right: kDefaultPadding * 2),

                        padding: EdgeInsets.all( kDefaultPadding ),
                        decoration: circularEdges(20, 20, 20, 20, Colors.white),
                        child: LineChart(

                          mainData( orderList.maxEarning, orderList.spots ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(top : kDefaultPadding * 2, left:  kDefaultPadding * 3),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Earnings this Month",
                                  style: TextStyle(
                                      color: kBase,
                                      fontSize: SizeConfig.heightMultiplier * 1.8,
                                      fontFamily: 'Nunito'
                                  ),
                                ),
                                Text(
                                  "RM "+orderList.totalEarned.toStringAsFixed(3),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: kBase,
                                      fontSize: SizeConfig.heightMultiplier * 2.4,
                                      fontFamily: 'Nunito'
                                  ),
                                ),
                              ],
                            )
                          ],),
                      )
                    ],
                  )
              ),
              Expanded(flex: 1,child: Container(),),*/
                              Expanded(
                                  flex: 15,
                                  child: Stack(
                                    children: [
                                      Container(
                                        height: double.infinity,
                                        width: SizeConfig.imageSizeMultiplier *
                                            100,
                                        padding:
                                            EdgeInsets.all(kDefaultPadding),
                                        margin: EdgeInsets.only(
                                            top: kDefaultPadding / 2,
                                            bottom: kDefaultPadding * 2,
                                            left: kDefaultPadding * 2,
                                            right: kDefaultPadding * 2),
                                        decoration: circularEdges(
                                            20, 20, 20, 20, Colors.white),
                                        child: LineChart(
                                          mainDataOrders(orderList.maxOrders,
                                              orderList.spotsOrder),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: kDefaultPadding * 2,
                                            left: kDefaultPadding * 3),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  english
                                                      ? "Orders this Month"
                                                      : "Pesanan Bulan Ini",
                                                  style: TextStyle(
                                                      color: kBase,
                                                      fontSize: SizeConfig
                                                              .heightMultiplier *
                                                          1.8,
                                                      fontFamily: 'Nunito'),
                                                ),
                                                Text(
                                                  orderList.orders.length
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: kBase,
                                                      fontSize: SizeConfig
                                                              .heightMultiplier *
                                                          2.4,
                                                      fontFamily: 'Nunito'),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  )),
                              Expanded(
                                flex: 5,
                                child: Container(),
                              )
                            ],
                          )
                        : Center(
                            child: Text(
                              "Not enough data",
                              style: TextStyle(
                                  fontSize: SizeConfig.heightMultiplier * 2.4),
                            ),
                          )
                : Center(
                    child: CircularProgressIndicator(
                      color: kGreen,
                    ),
                  );
          },
        ));
  }

  void _showDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return dialogWithList("Month", months, context, _orders);
        });
  }

  getOrdersList() async {
    Map<String, dynamic> responseGetOrderList = await getAllOrdersByRider();
    //Map<String ,dynamic > responseGetOrderList = {"status":200,"response":ordertemp};

    print(responseGetOrderList);

    if (responseGetOrderList["status"] == 200) {
      Provider.of<CompletedOrdersProvider>(_key.currentContext!, listen: false)
          .reset();
      Provider.of<CompletedOrdersProvider>(_key.currentContext!, listen: false)
          .updateMonth(DateTime.now().month);

      List<dynamic> ordersList = jsonDecode(responseGetOrderList["response"]);

      for (var order in ordersList) {
        List<dynamic> orderItems = order["products"];
        List<OrderItem> orderItemList = [];

        for (var item in orderItems) {
          orderItemList.add(OrderItem(
            name: item["name"],
            description: item["description"],
            sku: item["sku"],
            price: item["price"],
            quantity: item["quantity"],
            store: order["franchiseName"],
          ));
        }

        _orders.add(OrderDetails(
            distance: order["estTravelDistance"].toString(),
            timeDelivery: order["deliveryTime"]
                .toString()
                .replaceAll("T", " ")
                .split(".")[0],
            orderNumber: order["refNo"],
            total: order["totalBill"],
            refNo: order["refNo"],
            orderItems: orderItemList,
            customerDetails: CustomerDetails(
              address: order["deliveryAddress"],
            ),
            merchantDetails:  MerchantDetails(
              name: order["franchiseName"],
              address: order["franchiseAddress"],
            ), timePickup: ''));
      }

      for (var order in _orders) {
        String month = order.timeDelivery?.split("-")[1]??'-';
        if (month.substring(0, 1) == '0') {
          month = month.substring(1, 2);
        }
      }

      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          Provider.of<CompletedOrdersProvider>(_key.currentContext!,
                  listen: false)
              .updateList(_orders, DateTime.now().month);
          _loaded = true;
          error = false;
        });
      });
    } else {
      setState(() {
        _loaded = true;
        error = true;
        errorMessage = "No internet";
      });
      showSnackBar("Something went wrong, please try again later", _key);
    }
  }
}

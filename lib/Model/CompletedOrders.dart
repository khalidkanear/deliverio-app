import '/Screens/OrderInitiated/Model/OrderDetailsModel.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';




class CompletedOrdersProvider extends ChangeNotifier{


  List<OrderDetails> _orderList = [];
  List<OrderDetails> _lastMonthOrders = [];
  List<FlSpot> spots = [];
  List<FlSpot> spotsOrder = [];
  double maxEarning = 0.0;
  double maxOrders = 0.0;
  double totalEarned = 0.0;
  bool loaded = false;
  int selectedMonth = DateTime.now().month;


  List<OrderDetails> get orders{

    return _lastMonthOrders;

  }



  void reset(){
    loaded = false;
    spots = [];
    spotsOrder = [];
    notifyListeners();
  }


  void updateList(List<OrderDetails> orders, int month){


    _lastMonthOrders = [];
    _orderList = orders;
    maxEarning = 0;
    maxOrders = 0;
    totalEarned = 0;
    spots = [];
    spotsOrder = [];

    DateTime today = DateTime.now();



    /// Make List of Orders in this Month
    /// Make List of Orders in this Month
    /// Make List of Orders in this Month

    for (var order in _orderList) {


      int month =  int.parse(order.timeDelivery?.split("-")[1]??'-');


      if( month == month ){

        _lastMonthOrders.add(order);

      }


    }



    /// Make Graph Lists for both Earnings & Orders
    /// Make Graph Lists for both Earnings & Orders
    /// Make Graph Lists for both Earnings & Orders

    DateTime old = today;

    double oldPrice = 0.0;
    double oldOrderAmount = 0.0;


    for (var order in _lastMonthOrders) {

      int year =  int.parse(order.timeDelivery?.split("-")[0]??'-');
      int month =  int.parse(order.timeDelivery?.split("-")[1]??'-');
      int day =  int.parse(order.timeDelivery?.split("-")[2].split(" ")[0]??'-');

      DateTime orderDate = DateTime(year,month,day);

      totalEarned += order.total??0;

      ///Another Order for Same Day
      ///Another Order for Same Day
      if(orderDate.day == old.day && spots.isNotEmpty){

        oldPrice += order.total!;
        oldOrderAmount += 1;

        ///Remove Last added object
        spots.removeLast();
        spotsOrder.removeLast();

        ///Add new to earningsGraphList
        spots.add(
            FlSpot(orderDate.day.toDouble(),oldPrice)
        );

        ///Add new to ordersGraphList
        spotsOrder.add(
          FlSpot(orderDate.day.toDouble(), oldOrderAmount)
        );


        ///update Max Earning
        if(maxEarning <= oldPrice){
          maxEarning = oldPrice;
        }


        ///update Max Orders
        if(maxOrders <= oldOrderAmount){
          maxOrders = oldOrderAmount;
        }


        ///First Order for a Day
        ///First Order for a Day
      }else{

        ///Add new to earningsGraphList
        spots.add(
            FlSpot(orderDate.day.toDouble(),order.total??0.0)
        );

        ///Add new to ordersGraphList
        spotsOrder.add(
            FlSpot(orderDate.day.toDouble(), 1)
        );

        ///Update Max Earnings
        if(maxEarning <= order.total!){
          maxEarning = order.total??0.0;
        }

        ///Update Old price + OldOrderAmount
        ///Update Old price + OldOrderAmount
        oldPrice = order.total??0.0;
        oldOrderAmount = 1;
      }

      /// Old Order Date
      old = orderDate;
    }


    loaded = true;
    notifyListeners();


  }


  void updateMonth(int month){

    selectedMonth = month;
    notifyListeners();

  }



}
import '/Components/Loading.dart';
import '/Config.dart';
import '/Constants.dart';
import '/Screens/DragableList/Components/CheckItemsDialog.dart';
import '/Screens/DragableList/Model/SelectedItemsListener.dart';
import '/Screens/OrderInitiated/Model/MapChangeListener.dart';
import '/Screens/OrderInitiated/Model/OrderItem.dart';
import '/Screens/OrderInitiated/Model/OrderStatusListener.dart';
import '/WebServices/UpdateOrderStatus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../string.dart';

class OrderStatus extends StatefulWidget {
  List<OrderItem>? orderItems;

  OrderStatus({
    this.orderItems,
  });

  @override
  _OrderStatusState createState() => _OrderStatusState(orderItems: orderItems??[]);
}

class _OrderStatusState extends State<OrderStatus> {
  List<OrderItem>? orderItems;

  _OrderStatusState({this.orderItems});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: kDefaultPadding,
        ),
        Row(
          children: [
            Text(
              english ? "Order Status" : m["Order Status"].toString(),
              style: TextStyle(
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.bold,
                  fontSize: SizeConfig.heightMultiplier * 2.5),
            )
          ],
        ),
        Consumer<OrderStatusListener>(
          builder: (context, item, child) {
            return Container(
              padding: EdgeInsets.all(kDefaultPadding),
              decoration: circularEdges(20, 20, 20, 20, kGrey),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: circularEdges(
                            20, 20, 20, 20, kBase.withOpacity(.3)),
                        height: SizeConfig.heightMultiplier * 1.5,
                        width: SizeConfig.heightMultiplier * 1.5,
                      ),
                      SizedBox(
                        width: kDefaultPadding,
                      ),
                      Text(
                        english ? "Accepted" : m["Accepted"].toString(),
                        style: TextStyle(
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w600,
                            fontSize: SizeConfig.heightMultiplier * 2),
                      ),
                      const Spacer(),
                      const Icon(Icons.check, color: Colors.black)
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        decoration: circularEdges(
                            20, 20, 20, 20, kBase.withOpacity(.3)),
                        height: SizeConfig.heightMultiplier * 1.5,
                        width: SizeConfig.heightMultiplier * 1.5,
                      ),
                      SizedBox(
                        width: kDefaultPadding,
                      ),
                      Text(
                        english ? "Picked" : m["Picked"].toString(),
                        style: TextStyle(
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w600,
                            fontSize: SizeConfig.heightMultiplier * 2),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.check,
                        color: (item.orderStatus == 1 || item.orderStatus == 2)
                            ? Colors.black
                            : Colors.transparent,
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        decoration: circularEdges(
                            20, 20, 20, 20, kBase.withOpacity(.3)),
                        height: SizeConfig.heightMultiplier * 1.5,
                        width: SizeConfig.heightMultiplier * 1.5,
                      ),
                      SizedBox(
                        width: kDefaultPadding,
                      ),
                      Text(
                        english ? "Delivered" : m["Delivered"].toString(),
                        style: TextStyle(
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w600,
                            fontSize: SizeConfig.heightMultiplier * 2),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.check,
                        color: item.orderStatus == 2
                            ? Colors.black
                            : Colors.transparent,
                      )
                    ],
                  ),
                  InkWell(
                    onTap: () async {
                      if (item.orderStatus < 2) {
                        Provider.of<SelectedItem>(context, listen: false)
                            .initialize(orderItems?.length??0);
                        print("${item.orderStatus}ORDER STATUS ++++++++++++++++++");

                        /// MARK ORDER PICKED
                        /// MARK ORDER PICKED
                        if (item.orderStatus == 0) {
                          _showDialog(context);
                        } else if (item.orderStatus == 1) {
                          ///Loading
                          ///Loading
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return loading;
                              });

                          Map<String, dynamic> response =
                              await UpdateOrderStatus(
                                      status: 3, cashCollected: true)
                                  .statusUpadateReq();

                          ///Pop Loader
                          ///Pop Loader
                          Navigator.of(context).pop();

                          if (response["status"] == 200) {
                            print("aya");

                            SharedPreferences pref =
                                await SharedPreferences.getInstance();

                            pref.setString("OrderStatus", "Delivered");

                            Provider.of<OrderStatusListener>(context,
                                    listen: false)
                                .updateStatus(0);

                            Provider.of<MapChangeListener>(context,
                                    listen: false)
                                .resetAll();
                            Provider.of<SelectedItem>(context, listen: false)
                                .reset();

                            accepted = false;

                            Navigator.pushReplacementNamed(
                                context, "/captureImage");
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                              response["response"],
                              style: TextStyle(
                                fontSize: SizeConfig.heightMultiplier * 2.0,
                              ),
                            )));
                          }
                        }
                      }
                    },
                    child: Container(
                        decoration: circularEdges(
                            15,
                            15,
                            15,
                            15,
                            item.orderStatus == 2
                                ? Colors.black.withOpacity(.1)
                                : kBase),
                        padding: EdgeInsets.symmetric(
                          vertical: kDefaultPadding,
                        ),
                        margin: EdgeInsets.only(
                          top: kDefaultPadding,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(item.statuses[item.orderStatus],
                                style: Theme.of(context).textTheme.headline6),
                          ],
                        )),
                  )
                ],
              ),
            );
          },
        )
      ],
    );
  }

  _showDialog(BuildContext context) {
    // Vibration.vibrate(
    //   pattern: [500, 1000, 500, 1000, 500, 1000, 500, 500],
    //   intensities: [128, 255, 64, 255],
    // );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return checkItemsDialog(context, orderItems??[]);
        });
  }
}

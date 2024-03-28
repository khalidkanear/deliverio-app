import '/Screens/OrderInitiated/Model/OrderDetailsModel.dart';
import '/Screens/OrderInitiated/Model/OrderItem.dart';
import 'package:flutter/material.dart';
import '../Config.dart';
import '../Constants.dart';
import '../string.dart';

Widget orderDetailsDialogue(BuildContext context, OrderDetails order) {
  List<OrderItem> products = order.orderItems??[];

  return AlertDialog(
    elevation: 0,
    insetPadding: EdgeInsets.symmetric(
        horizontal: SizeConfig.heightMultiplier * 2,
        vertical: kDefaultPadding * 2),
    contentPadding: const EdgeInsets.all(0),
    backgroundColor: Colors.transparent,
    content: Container(
      width: SizeConfig.imageSizeMultiplier * 100,
      decoration: circularEdges(20, 20, 20, 20, kBase),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.all(kDefaultPadding * 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    english ? "ORDER DETAILS" : m["ORDER DETAILS"].toString(),
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: kDefaultPadding / 2,
                  vertical: kDefaultPadding / 2),
              decoration: circularEdges(0, 0, 20, 20, Colors.white),
              child: Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: kDefaultPadding / 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                english
                                    ? "Order Number"
                                    : "${m["Order Number"]} : ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: SizeConfig.heightMultiplier * 2.0,
                                ),
                              ),
                              Text(
                                "#${order.refNo}",
                                style: TextStyle(
                                  fontSize: SizeConfig.heightMultiplier * 2.0,
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: EdgeInsets.all(kDefaultPadding / 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                english
                                    ? "Product Detail"
                                    : m["Product Detail"].toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: SizeConfig.heightMultiplier * 2.0,
                                ),
                              ),
                              Text(
                                english ? "Total" : m["Total"].toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: SizeConfig.heightMultiplier * 2.0,
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Container(
                        decoration: circularEdges(20, 20, 20, 20, kGrey),
                        child: SingleChildScrollView(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: products
                                  .map(
                                    (product) => Container(
                                      margin: EdgeInsets.all(kDefaultPadding),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 5,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(product.name.toString(),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: SizeConfig
                                                                .heightMultiplier *
                                                            1.75,
                                                        fontFamily: 'Nunito')),
                                                SizedBox(
                                                  height: kDefaultPadding / 2,
                                                ),
                                                Text(
                                                  "SKU: ${product.sku}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline3
                                                      ?.copyWith(
                                                          color: Colors.black
                                                              .withOpacity(.6)),
                                                ),
                                                Text(
                                                  english
                                                      ? "Store"
                                                      : "${m["Store"]}: ${product.store}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline3
                                                      ?.copyWith(
                                                          color: Colors.black
                                                              .withOpacity(.6)),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                    "x${product.quantity}",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: SizeConfig
                                                                .heightMultiplier *
                                                            2,
                                                        fontFamily: 'Nunito')),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text("RM",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: SizeConfig
                                                                .heightMultiplier *
                                                            1.8,
                                                        fontFamily: 'Nunito')),
                                                Text(
                                                    '${product.quantity}' *  int.parse('${product.price}')
                                                        ,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: SizeConfig
                                                                .heightMultiplier *
                                                            1.8,
                                                        fontFamily: 'Nunito')),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                  .toList()),
                        )),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(kDefaultPadding / 3),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 5,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      english
                                          ? "Delivery Charges"
                                          : "${m["Delivery Charges"]}: ",
                                      style: TextStyle(
                                          fontSize:
                                              SizeConfig.heightMultiplier * 2,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      "RM 0.00",
                                      style: TextStyle(
                                        fontSize:
                                            SizeConfig.heightMultiplier * 2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(kDefaultPadding / 3),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 5,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      english
                                          ? "Grand Total"
                                          : "${m["Grand Total"]}: ",
                                      style: TextStyle(
                                          fontSize:
                                              SizeConfig.heightMultiplier * 2,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "RM ${order.total?.toStringAsFixed(2)}",
                                      style: TextStyle(
                                        fontSize:
                                            SizeConfig.heightMultiplier * 2,
                                      ),
                                      textAlign: TextAlign.right,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}

import '/Screens/OrderInitiated/Model/OrderItem.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../Config.dart';
import '../Constants.dart';

class CarouselWithIndicator extends StatefulWidget {
   List<OrderItem>? items=[];

  CarouselWithIndicator({ this.items});

  @override
  State<StatefulWidget> createState() {
    return _carouselWithIndicators(orderItems: items??[]);
  }
}

class _carouselWithIndicators extends State {
  List<OrderItem> ?orderItems;

  _carouselWithIndicators({ this.orderItems});

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        ///Carousel  Slider
        ///Carousel  Slider
        CarouselSlider(
          //OPTIONS
          options: CarouselOptions(
              viewportFraction: 1,
              height: SizeConfig.heightMultiplier * 15,
              onPageChanged: (index, reason) {
                setState(() {
                  selectedIndex = index;
                });
              }),

          items: orderItems!
              .map(
                (item) => Container(
                    width: MediaQuery.of(context).size.width,
                    margin:
                        EdgeInsets.symmetric(horizontal: kDefaultPadding / 4),
                    decoration: circularEdges(20, 20, 20, 20, kGrey),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          flex: 8,
                          child: Padding(
                            padding: EdgeInsets.all(kDefaultPadding / 1.5),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FittedBox(
                                    child: Text(
                                  item.name.toString(),
                                  style: TextStyle(
                                      fontSize: SizeConfig.heightMultiplier * 2,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Nunito"),
                                )),
                                FittedBox(
                                    child: Text(
                                  'SKU: ${item.sku}',
                                  style: TextStyle(
                                      fontSize:
                                          SizeConfig.heightMultiplier * 1.6,
                                      fontFamily: "Nunito"),
                                )),
                                FittedBox(
                                    child: Text(
                                  'Store: ${item.store}',
                                  style: TextStyle(
                                      fontSize:
                                          SizeConfig.heightMultiplier * 1.6,
                                      fontFamily: "Nunito"),
                                )),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding:
                                EdgeInsets.only(right: kDefaultPadding / 2),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'x${item.quantity}',
                                  style: TextStyle(
                                      fontSize: SizeConfig.heightMultiplier * 2,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Nunito"),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    )),
              )
              .toList(),
        ),

        ///Indicator
        ///Indicator
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: orderItems!.map((url) {
            int index = orderItems!.indexOf(url);
            return Container(
                width: selectedIndex == index
                    ? SizeConfig.imageSizeMultiplier * 10
                    : 8.0,
                height: selectedIndex == index ? 10.0 : 8.0,
                margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: circularEdges(20, 20, 20, 20,
                    selectedIndex == index ? kBase : kOrange.withOpacity(.3)));
          }).toList(),
        ),
      ],
    );
  }
}

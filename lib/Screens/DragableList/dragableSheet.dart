import 'package:android_intent_plus/android_intent.dart';
import '/Components/OrderDetailDialogue.dart';
import '/Constants.dart';
import '/Screens/OrderInitiated/Model/OrderDetailsModel.dart';
import 'package:flutter/material.dart';
import 'package:platform/platform.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Config.dart';
import '../../string.dart';
import 'Components/OrderStatus.dart';
import '../../Components/carouselWithIndicator.dart';

class DragableList extends StatelessWidget {

  OrderDetails? orderDetails;
  @override
  GlobalKey<ScaffoldState>? key;



  DragableList({
     this.orderDetails,
    this.key
  });

  int currentIndex = 0;


  _showDialog(BuildContext context ){

    // Vibration.vibrate(
    //   pattern: [500, 1000, 500, 1000, 500, 1000, 500, 500],
    //   intensities: [128, 255, 64, 255],
    // );

    showDialog(
        context: context,
        builder:(BuildContext context){
          return orderDetailsDialogue(context, orderDetails!);
        }
    );

  }


  @override
  Widget build(BuildContext context) {

    return Container(
      child: DraggableScrollableSheet(
          minChildSize: .15,
          initialChildSize: .2,
          builder: (context, controller){
            return SingleChildScrollView(
              controller: controller,
              child: Container(
                decoration: circularEdges(20, 20, 20, 20, Colors.transparent),
                padding: EdgeInsets.all(kDefaultPadding),
                child: Column(children: [

                  InkWell(
                      onTap: ()async {


                      },

                      child: buildCallTile(orderDetails?.merchantDetails?.name , english ? "Pickup Time" : m["Pickup Time"]! + ": " + '${orderDetails?.timePickup}', orderDetails?.merchantDetails?.image, orderDetails?.merchantDetails?.phoneNo.toString())),

                  SizedBox(height: kDefaultPadding,),
                  buildCallTile(orderDetails?.customerDetails?.name, english ? "Delivery" : "${m["Delivery"]}: ${orderDetails?.timeDelivery}", orderDetails?.customerDetails?.image, orderDetails?.customerDetails?.phoneNo),
                  SizedBox(height: kDefaultPadding,),


                  Material(
                    elevation: 4,
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    child: Container(
                      padding: EdgeInsets.all(kDefaultPadding),
                      child: Column(children: [

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(english ? "Addresses" : m["Addresses"].toString(), style:TextStyle(
                                fontSize: SizeConfig.heightMultiplier * 2.5,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Nunito'
                            ),),
                            InkWell(
                              onTap: ()async{
                                String origin= "${orderDetails?.merchantDetails?.lat},${orderDetails?.merchantDetails?.long}";  // lat,long like 123.34,68.56
                                String destination="${orderDetails?.customerDetails?.lat},${orderDetails?.customerDetails?.long}";

                                if (const LocalPlatform().isAndroid) {
                                  final AndroidIntent intent = AndroidIntent(
                                      action: 'action_view',
                                      data: Uri.encodeFull(
                                          "https://www.google.com/maps/dir/?api=1&origin=$currentLoc&destination=$destination&waypoints=$origin&travelmode=driving&dir_action=navigate"),

                                      package: 'com.google.android.apps.maps');
                                  intent.launch();
                                }
                                else {
                                  String url = "https://www.google.com/maps/dir/?api=1&origin=$currentLoc&destination=$destination&waypoints=$origin&travelmode=driving&dir_action=navigate";
                                  if (await canLaunch(url)) {
                                await launch(url);
                                } else {
                                throw 'Could not launch $url';
                                }
                              }

                              },
                              child: Padding(
                                padding: EdgeInsets.only(right:  kDefaultPadding/4),
                                child: Text(english ? "Navigate" : m["Navigate"].toString(), style:TextStyle(
                                    fontSize: SizeConfig.heightMultiplier * 2,
                                    fontFamily: 'Nunito',
                                    color: kBase
                                ),),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.all(kDefaultPadding),
                          decoration: circularEdges(20, 20, 20, 20, kGrey),
                          child: Column(
                            children: [
                              Row(children: [

                                SizedBox(width: kDefaultPadding,),

                                Container(
                                  height: kDefaultPadding,
                                  width: kDefaultPadding,
                                  decoration: circularEdges(20, 20, 20, 20, kBase),
                                ),

                                SizedBox(width: kDefaultPadding,),

                                ///Pickup Address
                                ///Pickup Address
                                Expanded(
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(english ?  "Pickup" : "${m["Pickup"]}: ${orderDetails?.merchantDetails?.address}", style:TextStyle(
                                            fontSize: SizeConfig.heightMultiplier * 1.8,
                                            fontFamily: 'Nunito'
                                        ),

                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                              ],),
                              Row(children: [
                                SizedBox(width: kDefaultPadding,),
                                Container(
                                  height: kDefaultPadding,
                                  width: kDefaultPadding,
                                  padding: EdgeInsets.all(kDefaultPadding/3),
                                  decoration: circularEdges(20, 20, 20, 20, kGrey),
                                  child: Container(
                                    decoration: circularEdges(20, 20, 20, 20,kBase),

                                  ),
                                ),
                              ],),
                              Row(children: [
                                SizedBox(width: kDefaultPadding,),
                                Container(
                                  height: kDefaultPadding,
                                  width: kDefaultPadding,
                                  padding: EdgeInsets.all(kDefaultPadding/3),
                                  decoration: circularEdges(20, 20, 20, 20, kGrey),
                                  child: Container(
                                    decoration: circularEdges(20, 20, 20, 20,kBase),

                                  ),
                                ),
                              ],),
                              Row(children: [
                                SizedBox(width: kDefaultPadding,),
                                Container(
                                  height: kDefaultPadding,
                                  width: kDefaultPadding,
                                  padding: EdgeInsets.all(kDefaultPadding/3),
                                  decoration: circularEdges(20, 20, 20, 20, kGrey),
                                  child: Container(
                                    decoration: circularEdges(20, 20, 20, 20,kBase),

                                  ),
                                ),
                              ],),
                              Row(children: [

                                SizedBox(width: kDefaultPadding,),

                                Container(
                                  height: kDefaultPadding,
                                  width: kDefaultPadding,
                                  padding: EdgeInsets.all(kDefaultPadding/6),
                                  decoration: circularEdges(20, 20, 20, 20, kBase),
                                  child: Container(
                                    decoration: circularEdges(20, 20, 20, 20,kGrey),

                                  ),
                                ),

                                SizedBox(width: kDefaultPadding,),

                                ///Delivery Address
                                ///Delivery Address
                                Expanded(
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(english ? "Delivery" : "${m["Delivery"]}: ${orderDetails?.customerDetails?.address}", style:TextStyle(
                                            fontSize: SizeConfig.heightMultiplier * 1.8,
                                            fontFamily: 'Nunito'
                                        ),

                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                              ],),
                            ],
                          ),
                        ),
                        SizedBox(height: kDefaultPadding,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(english ? "Order Details" : m["Order Details"].toString(), style:TextStyle(
                                fontSize: SizeConfig.heightMultiplier * 2.5,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Nunito'
                            ),),
                            InkWell(
                              onTap: (){
                                _showDialog(context);
                                //Navigator.pushNamed(context, '/orderItems');
                              },
                              child: Padding(
                                padding: EdgeInsets.only(right:  kDefaultPadding/4),
                                child: Text(english ? "Expand" : m["Expand"].toString(), style:TextStyle(
                                    fontSize: SizeConfig.heightMultiplier * 2,
                                    fontFamily: 'Nunito',
                                  color: kBase
                                ),),
                              ),
                            ),
                          ],
                        ),

                        ///ORDER ITEMS
                        ///ORDER ITEMS
                        ///ORDER ITEMS
                        Container(
                          child: CarouselWithIndicator(items: orderDetails?.orderItems,)
                        ),

                        /// ORDER STATUS
                        /// ORDER STATUS
                        /// ORDER STATUS
                        OrderStatus(orderItems: orderDetails?.orderItems)

                      ],),
                    ),
                  )

                ],),
              ),
            );
          },
      ),
    );


  }
  Widget buildCallTile(String? title, String? subtitle, String? Image, String? phone) {
    return Material(
      elevation: 4,
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      child: Container(
        padding: EdgeInsets.all(kDefaultPadding/2),
        decoration: circularEdges(20, 20, 20, 20, Colors.white),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: kOrange.withOpacity(.1),
            radius: SizeConfig.heightMultiplier * 3,),
          title: Text('$title', style:TextStyle(
            fontSize: SizeConfig.heightMultiplier * 2,
            fontWeight: FontWeight.bold,
          ),),
          subtitle: Text("$subtitle", style:TextStyle(
            fontSize: SizeConfig.heightMultiplier * 1.6,
          ),),

          trailing: InkWell(
            onTap: ()async{


                String url = "tel:$phone";
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  throw 'Could not launch $url';
                }

            },
            child: CircleAvatar(
              backgroundColor: kBase,
              radius: SizeConfig.heightMultiplier * 3,
              child: const Icon(Icons.call_rounded,color: Colors.white,),
            ),
          ),

        ),
      ),
    );
  }

}

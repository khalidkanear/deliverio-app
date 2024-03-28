import 'package:assets_audio_player/assets_audio_player.dart';
import '/Screens/HomeScreen/Models/OrderAlert.dart';
import '/Screens/OrderInitiated/OrderInitiated.dart';
import '/WebServices/AcceptOrder.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:vibration/vibration.dart';

import '../Config.dart';
import '../Constants.dart';

AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();

Widget buildOrderAlert(BuildContext dContext, OrderAlertModel order) {
  assetsAudioPlayer.open(
    Audio("assets/alert.mp3"),
  );

  Future.delayed(const Duration(seconds: 25), () async {
    if (Navigator.of(dContext).canPop() && !accepted) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.remove("orderId");
      assetsAudioPlayer.stop();
      Navigator.of(dContext).pop();
    }
  });

  return AlertDialog(
    elevation: 0,
    insetPadding: EdgeInsets.all(SizeConfig.heightMultiplier * 2),
    contentPadding: const EdgeInsets.all(0),
    backgroundColor: Colors.transparent,
    content: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.heightMultiplier,
              vertical: SizeConfig.heightMultiplier * 1.5),
          width: SizeConfig.imageSizeMultiplier * 100,
          margin: EdgeInsets.symmetric(horizontal: SizeConfig.heightMultiplier),
          decoration: circularEdges(20, 20, 20, 20, Colors.white),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(SizeConfig.heightMultiplier),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 2,
                      child: SizedBox(
                          height: SizeConfig.heightMultiplier * 8,
                          width: SizeConfig.heightMultiplier * 8,
                          child: const CircleAvatar()),
                    ),
                    Expanded(
                      flex: 7,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            FittedBox(
                                child: Text(
                              '${order.franchiseName}',
                              style: Theme.of(dContext)
                                  .textTheme
                                  .headline2
                                  ?.copyWith(fontWeight: FontWeight.bold),
                              overflow: TextOverflow.fade,
                            )),
                            //FittedBox(child: Text(english ? "Pickup : " : "Ambil Di : " +_order.pickTime + " minutes", style: Theme.of(dContext).textTheme.headline3,)),
                            //SizedBox(height: kDefaultPadding/2,)
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          Text(
                            "RM",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontFamily: 'Nunito',
                                fontSize: SizeConfig.heightMultiplier * 2.5),
                          ),
                          FittedBox(
                            child: Text(
                              '${order.deliveryFee}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontFamily: 'Nunito',
                                  fontSize: SizeConfig.heightMultiplier * 2.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(SizeConfig.heightMultiplier),
                child: ListTile(
                  title: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0),
                    child: Row(
                      children: [
                        Container(
                          height: SizeConfig.heightMultiplier * 2,
                          width: SizeConfig.heightMultiplier * 2,
                          decoration: circularEdges(100, 100, 100, 100, kBase),
                        ),
                        SizedBox(
                          width: kDefaultPadding / 2,
                        ),
                        Expanded(
                          child: Text(
                            english
                                ? "Pickup : ${order.franchiseAddress}"
                                : "Ambil Di :  ${order.franchiseAddress}",
                            style: Theme.of(dContext).textTheme.headline3,
                            overflow: TextOverflow.fade,
                          ),
                        )
                      ],
                    ),
                  ),
                  subtitle: Row(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: SizeConfig.heightMultiplier * 2,
                            width: SizeConfig.heightMultiplier * 2,
                            decoration:
                                circularEdges(100, 100, 100, 100, kBase),
                          ),
                          Center(
                              child: Container(
                                  height: SizeConfig.heightMultiplier * 1.5,
                                  width: SizeConfig.heightMultiplier * 1.5,
                                  decoration: circularEdges(
                                      100, 100, 100, 100, Colors.white))),
                        ],
                      ),
                      SizedBox(
                        width: kDefaultPadding / 2,
                      ),
                      Flexible(
                          child: Text(
                        english
                            ? "Delivery : ${order.deliveryAddress}"
                            : "Hantar ke : ${order.deliveryAddress}",
                        style: Theme.of(dContext).textTheme.headline3,
                        overflow: TextOverflow.fade,
                      ))
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(SizeConfig.heightMultiplier),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: circularEdges(100, 100, 100, 100, kGrey),
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.heightMultiplier,
                          vertical: SizeConfig.heightMultiplier / 2),
                      child: Row(
                        children: [
                          Icon(
                            Icons.call_rounded,
                            color: kBase,
                            size: SizeConfig.heightMultiplier * 2.5,
                          ),
                          Text(
                            " Call",
                            style: Theme.of(dContext).textTheme.headline3,
                          )
                        ],
                      ),
                    ),
                    Container(
                      decoration: circularEdges(100, 100, 100, 100, kGrey),
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.heightMultiplier,
                          vertical: SizeConfig.heightMultiplier / 2),
                      child: Row(
                        children: [
                          Icon(
                            Icons.message_rounded,
                            color: kBase,
                            size: SizeConfig.heightMultiplier * 2.5,
                          ),
                          Text(
                            " Message",
                            style: Theme.of(dContext).textTheme.headline3,
                          )
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        SharedPreferences pref =
                            await SharedPreferences.getInstance();
                        pref.remove("orderId");
                        Vibration.cancel();
                        orderInQueue = false;
                        assetsAudioPlayer.stop();
                        Navigator.of(dContext).pop();
                      },
                      child: Container(
                        decoration: circularEdges(100, 100, 100, 100, kGrey),
                        padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.heightMultiplier,
                            vertical: SizeConfig.heightMultiplier / 2),
                        child: Row(
                          children: [
                            Icon(
                              Icons.cancel_rounded,
                              color: kBase,
                              size: SizeConfig.heightMultiplier * 2.5,
                            ),
                            Text(
                              " Cancel",
                              style: Theme.of(dContext).textTheme.headline3,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    EdgeInsets.symmetric(vertical: SizeConfig.heightMultiplier),
                child: SlideAction(
                  onSubmit: () async {
                    SharedPreferences pref =
                        await SharedPreferences.getInstance();
                    pref.remove("orderId");
                    _acceptOrder(dContext);
                  },
                  sliderButtonIcon: const Icon(Icons.arrow_forward_ios_rounded),
                  text: english ? "Accept Order" : "Terima Pesanan",
                  elevation: 0,
                  outerColor: kGrey,
                  innerColor: kBase,
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: SizeConfig.heightMultiplier * 8,
        )
      ],
    ),
  );
}

void _acceptOrder(BuildContext context) async {
  assetsAudioPlayer.stop();
  Vibration.cancel();

  Map<String, dynamic> response = await AcceptOrder().orderAcceptReq();

  if (response["status"] == 200) {
    orderInQueue = false;
    SharedPreferences pref = await SharedPreferences.getInstance();

    pref.setString("orderDetails", response["response"]);
    pref.setString("orderId", orderId.toString());
    orderDetailGlobal = response["response"];

    Navigator.of(context).pop();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => OrderInitiated()));
  } else {
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(50))),
      elevation: 6,
      margin: EdgeInsets.all(SizeConfig.heightMultiplier * 5),
      backgroundColor: Colors.white,
      duration: const Duration(milliseconds: 4000),
      content: Container(
        padding: EdgeInsets.all(SizeConfig.heightMultiplier),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                response["response"] ==
                        "Order already assigned to another Rider."
                    ? "Pesanan Sudah Diterima Oleh Penunggang Lain."
                    : response["response"],
                style: Theme.of(context)
                    .textTheme
                    .headline3
                    ?.copyWith(fontSize: SizeConfig.heightMultiplier * 2.0),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

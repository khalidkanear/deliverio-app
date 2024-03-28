import '/Components/OrderAlert.dart';
import '/Config.dart';
import '/Screens/HomeScreen/Models/OrderAlert.dart';
import '/Screens/OrderInitiated/OrderInitiated.dart';
import '/WebServices/AcceptOrder.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slide_to_act/slide_to_act.dart';

import '../../../Constants.dart';

class DialogScreen extends StatefulWidget {

   OrderAlertModel? order;

  DialogScreen({
    this.order
  });

  @override
  _DialogScreenState createState() => _DialogScreenState();
}




class _DialogScreenState extends State<DialogScreen> {



  @override
  Widget build(BuildContext context) {




    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding:EdgeInsets.symmetric(horizontal: SizeConfig.heightMultiplier, vertical: SizeConfig.heightMultiplier * 1.5),
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
                            child: const CircleAvatar()
                        ),
                      ),


                      Expanded(
                        flex: 7,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FittedBox(child: Text('${widget.order?.franchiseName}',style: Theme.of(context).textTheme.headline2,overflow: TextOverflow.fade,)),
                              FittedBox(child: Text("Pickup : "'${widget.order?.pickTime}' " minutes", style: Theme.of(context).textTheme.headline3,)),
                            ],),
                        ),
                      ),

                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            Text("RM", style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontFamily: 'Nunito',
                                fontSize: SizeConfig.heightMultiplier * 2.5
                            ),),
                            FittedBox(
                              child: Text('{$widget.order?.deliveryFee}', style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontFamily: 'Nunito',
                                  fontSize: SizeConfig.heightMultiplier * 2.5
                              ),),
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
                          Container(height:SizeConfig.heightMultiplier *2 , width:SizeConfig.heightMultiplier *2 , decoration: circularEdges(100, 100, 100, 100, kBase),),
                          SizedBox(width: kDefaultPadding/2,),
                          Flexible(child: Text("Pickup : "'${widget.order?.franchiseAddress}', style: Theme.of(context).textTheme.headline3, overflow: TextOverflow.fade,))
                        ],),
                    ),
                    subtitle: Row(children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(height:SizeConfig.heightMultiplier *2 , width:SizeConfig.heightMultiplier *2 , decoration: circularEdges(100, 100, 100, 100, kBase),),
                          Center(child: Container(height:SizeConfig.heightMultiplier *1.5 , width: SizeConfig.heightMultiplier *1.5 , decoration: circularEdges(100, 100, 100, 100, Colors.white))),

                        ],
                      ),
                      SizedBox(width: kDefaultPadding/2,),

                      Flexible(child: Text("Delivery : ${widget.order?.deliveryAddress}", style: Theme.of(context).textTheme.headline3, overflow: TextOverflow.fade,))
                    ],),

                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(SizeConfig.heightMultiplier),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: circularEdges(100, 100, 100, 100, kGrey),

                        padding: EdgeInsets.symmetric(horizontal:SizeConfig.heightMultiplier, vertical:SizeConfig.heightMultiplier/2),
                        child: Row(
                          children: [
                            Icon(Icons.call_rounded,color: kBase,size: SizeConfig.heightMultiplier*2.5,),
                            Text(" Call",style: Theme.of(context).textTheme.headline3,)
                          ],
                        ),
                      ),
                      Container(
                        decoration: circularEdges(100, 100, 100, 100, kGrey),
                        padding: EdgeInsets.symmetric(horizontal:SizeConfig.heightMultiplier, vertical:SizeConfig.heightMultiplier/2),
                        child: Row(
                          children: [
                            Icon(Icons.message_rounded,color: kBase,size: SizeConfig.heightMultiplier*2.5,),
                            Text(" Message",style: Theme.of(context).textTheme.headline3,)
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: (){

                          assetsAudioPlayer.stop();
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          decoration: circularEdges(100, 100, 100, 100, kGrey),

                          padding: EdgeInsets.symmetric(horizontal:SizeConfig.heightMultiplier, vertical:SizeConfig.heightMultiplier/2),
                          child: Row(
                            children: [
                              Icon(Icons.cancel_rounded,color: kBase,size: SizeConfig.heightMultiplier*2.5,),
                              Text(" Cancel",style: Theme.of(context).textTheme.headline3,)
                            ],
                          ),
                        ),
                      ),
                    ],),
                ),

                Container(
                  padding: EdgeInsets.symmetric( vertical: SizeConfig.heightMultiplier),
                  child: SlideAction(



                    onSubmit: ()=> _acceptOrder(context),


                    sliderButtonIcon: const Icon(Icons.arrow_forward_ios_rounded),
                    text: "Accept Order",
                    elevation: 0,
                    outerColor: kGrey,
                    innerColor: kBase,

                  ),
                )

              ],
            ),
          ),
          SizedBox(height: SizeConfig.heightMultiplier * 8,)
        ],
      ),
    );

  }



  void _acceptOrder(BuildContext context)async {


    assetsAudioPlayer.stop();

    Map<String,dynamic> response = await AcceptOrder().orderAcceptReq();

    if(response["status"] == 200){

      SharedPreferences pref = await SharedPreferences.getInstance();


      pref.setString("orderDetails", response["response"]);
      pref.setString("orderId", orderId.toString());
      orderDetailGlobal = response["response"];

      Navigator.of(context).pop();
      Navigator.pushReplacement(context, MaterialPageRoute(  builder: (context)=> OrderInitiated()));

    }




  }

}

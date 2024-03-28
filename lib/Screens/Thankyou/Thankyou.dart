import '/Components/flatTextButton.dart';
import '/Config.dart';
import '/Constants.dart';
import 'package:flutter/material.dart';

import '../../string.dart';

class Thankyou extends StatefulWidget {

  @override
  _ThankyouState createState() => _ThankyouState();
}




class _ThankyouState extends State<Thankyou> {

  String message = english ? "Thank You!" : m["Thank You!"].toString();
  Color color = kBase.withOpacity(.08);
  double size = SizeConfig.heightMultiplier * 20;
  double scale = 1;



  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.white,


        body: Column(children: [


          SizedBox(height: kDefaultPadding * 6,),


          Center(
            child: AnimatedContainer(

              duration: const Duration(milliseconds: 200),

              child: Text(english ? "Order Completed" : m["Order Completed"].toString(), style: Theme.of(context).textTheme.headline1?.copyWith(fontSize: SizeConfig.heightMultiplier * 3.5 , color: kBase, fontWeight: FontWeight.bold), ),

            ),
          ),

         const Spacer(),

          Transform.scale(
              scale: scale,
              child: Icon(Icons.thumb_up_alt_rounded, color: color, size: size, )),


          Center(
            child: AnimatedContainer(

              duration: const Duration(milliseconds: 200),

              child: Text(message, style: Theme.of(context).textTheme.headline1?.copyWith(fontSize: SizeConfig.heightMultiplier * 5.0 , color: kBase, fontWeight: FontWeight.bold), ),

            ),
          ),

          Center(
            child: AnimatedContainer(

              duration: const Duration(milliseconds: 200),

              child: Text("For your service", style: Theme.of(context).textTheme.headline1?.copyWith(fontSize: SizeConfig.heightMultiplier * 3.5 , color: Colors.transparent, ), ),

            ),
          ),


          const Spacer(),

          InkWell(
            onTap: () async {

                // SharedPreferences _pred = await  SharedPreferences.getInstance();
                // _pred.remove("orderDetails");

                Navigator.pushReplacementNamed(context, "/home");


              },


            child: Container(

              padding: EdgeInsets.all(SizeConfig.imageSizeMultiplier * 20 ),

              child: FlatTextButton(context, english ?  "HOME" : m["HOME"].toString(), double.infinity, kOrange),
            ),
          )



        ],)
    );

  }
}

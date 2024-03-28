import '/Config.dart';
import '/Constants.dart';
import 'package:flutter/material.dart';

import '../../string.dart';




class ErrorScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: SizeConfig.heightMultiplier  * 100 ,
            width: SizeConfig.imageSizeMultiplier * 100,
            child: Image.asset("assets/images/error.png", fit: BoxFit.fitWidth,),
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Padding(
                padding: EdgeInsets.all(kDefaultPadding * 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(children: [

                      Text("Oh no!",

                        style: Theme.of(context).textTheme.headline1,
                        textAlign: TextAlign.center,
                      )

                    ],),


                    Column(
                      children: [

                        Text("Something went wrong, Please try again.",

                          style: Theme.of(context).textTheme.headline2,
                          textAlign: TextAlign.center,
                        )

                      ],),


                  ],
                ),
              ),




              Padding(
                padding: EdgeInsets.only(bottom: kDefaultPadding * 2 , ),
                child: Container(

                    height: SizeConfig.heightMultiplier * 6,
                    width: SizeConfig.imageSizeMultiplier * 30,
                    decoration: circularEdges(
                        SizeConfig.heightMultiplier * 5,
                        SizeConfig.heightMultiplier * 5,
                        SizeConfig.heightMultiplier * 5,
                        SizeConfig.heightMultiplier * 5,
                        kOrange
                    ),



                    child: GestureDetector(
                      onTap: (){

                        Navigator.pushReplacementNamed(context, "/welcome");

                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(english ? "Home" : m["Home"].toString() ,style: Theme.of(context).textTheme.headline5?.copyWith(color: Colors.white, fontSize: SizeConfig.heightMultiplier * 2), ),
                        ],
                      ),
                    )
                )
              ),

            ],
          )
        ],
      ),
    );
  }
}

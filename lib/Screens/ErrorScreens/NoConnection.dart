

import '/Components/CloseAppDialog.dart';
import '/Config.dart';
import '/Constants.dart';
import 'package:flutter/material.dart';




class NoConnection extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(

        ///EXIT APPLICATION
        ///EXIT APPLICATION
        ///EXIT APPLICATION
        onWillPop: () async {

          showDialog(context: context, builder: (BuildContext context){
            return closeAppDialog(context);
          });

          return false;

        },

        child: Stack(
          children: [
            SizedBox(
              height: SizeConfig.heightMultiplier  * 100 ,
              width: SizeConfig.imageSizeMultiplier * 100,
              child: Image.asset("assets/images/noInternet.png", fit: BoxFit.fitWidth,),
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Padding(
                  padding: EdgeInsets.all(kDefaultPadding * 2),
                  child: Column(
                    children: [
                      Row(children: [

                        Text("Connection Lost",

                          style: Theme.of(context).textTheme.headline1,
                        )

                      ],),


                      Column(
                        children: [

                          Text("You have no internet access, please retry.",

                            style: Theme.of(context).textTheme.headline2,
                          )

                        ],),


                    ],
                  ),
                ),




                Padding(
                    padding: EdgeInsets.only(bottom: kDefaultPadding * 2 , left: kDefaultPadding * 2 ),
                    child: Container(

                        height: SizeConfig.heightMultiplier * 6,
                        width: SizeConfig.imageSizeMultiplier * 30,
                        decoration: circularEdges(
                            SizeConfig.heightMultiplier * 5,
                            SizeConfig.heightMultiplier * 5,
                            SizeConfig.heightMultiplier * 5,
                            SizeConfig.heightMultiplier * 5,
                            Colors.white
                        ),



                        child: GestureDetector(
                          onTap: (){

                            Navigator.pushReplacementNamed(context, "/");

                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Retry",style: Theme.of(context).textTheme.headline5?.copyWith(color: Colors.black), ),
                            ],
                          ),
                        )
                    )
                ),

              ],
            )
          ],
        ),
      )
    );
  }
}

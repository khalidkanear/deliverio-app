import '/Components/IndexIndicator.dart';
import '/Components/flatButton.dart';
import '/Config.dart';
import '/Constants.dart';
import 'package:flutter/material.dart';
import 'SplashScreen2.dart';



class SplashScreenOne extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Column(
        children: [

          Expanded(flex: 2,child: Container(),),
          Expanded(
              flex: 3,
              child: Container(child: Image.asset("assets/images/ss1.png"))),


          Expanded(
            flex:3,


            child: Column(children: [

              Padding(
                padding: EdgeInsets.all(kDefaultPadding * 2 ),
                child: RichText(
                  text: TextSpan(
                    // Note: Styles for TextSpans must be explicitly defined.
                    // Child text spans will inherit styles from parent
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                      TextSpan(text:"Deliver Orders ",style: Theme.of(context).textTheme.subtitle2,),
                      TextSpan( text :" and get a generous", style: Theme.of(context).textTheme.headline4 ),
                      TextSpan(text :" reward.", style: Theme.of(context).textTheme.subtitle2 ),
                    ],
                  ),
                ),
              ),

              ///Index Indicator +++++++++++++++++++++++++++++++++++++++++++++++++
              ///Index Indicator +++++++++++++++++++++++++++++++++++++++++++++++++
              Padding(
                padding: EdgeInsets.symmetric(horizontal: SizeConfig.heightMultiplier * 4),

                child: buildIndexIndicator(3,0),
              ),
              const Spacer(),

              ///Next Button      +++++++++++++++++++++++++++++++++++++++++++++++++
              ///Next Button      +++++++++++++++++++++++++++++++++++++++++++++++++
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                          onTap: ()=>nextScreen(context),
                          child: buildFlatButton()
                      ),
                    ],
                  ),

                ],
              )


            ],),),

        ],
      )
    );


  }



  nextScreen(BuildContext context) async {


    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => SplashScreenTwo(),
        transitionDuration: const Duration(seconds: 0),
      ),
    );


  }


}

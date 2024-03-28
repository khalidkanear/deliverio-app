import '/Components/IndexIndicator.dart';
import '/Components/flatButton.dart';
import 'package:flutter/material.dart';

import '../../Config.dart';
import '../../Constants.dart';

class SplashScreenTwo extends StatelessWidget {


  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        key: _key,
        body: Column(
          children: [

            Expanded(flex: 2,child: Container(),),
            Expanded(
                flex: 3,
                child: Container(child: Image.asset("assets/images/ss2.png",fit: BoxFit.cover,))),


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

                  child: buildIndexIndicator(3,1),
                ),
                const Spacer(),

                ///Next Button      +++++++++++++++++++++++++++++++++++++++++++++++++
                ///Next Button      +++++++++++++++++++++++++++++++++++++++++++++++++
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [

                    GestureDetector(
                        onTap: ()=> Navigator.pushReplacementNamed(context, '/welcome'),
                        child: buildFlatButton()
                    ),

                  ],
                )
              ],),
            ),
          ],
        )
    );


  }




}

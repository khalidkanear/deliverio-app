import 'package:flutter/material.dart';
import '../../../Config.dart';
import '/string.dart';

import '../../../Constants.dart';



Scaffold buildBody(BuildContext context) {





  return Scaffold(

    body: Column(children: [

      Expanded(
        flex: 10,
        child: Center(
          child: Text( english ? "WELCOME" : m["WELCOME"].toString() ,
            style: Theme.of(context).textTheme.subtitle2?.copyWith(fontSize: SizeConfig.heightMultiplier * 4),
          ),
        ),
      ),
      Expanded(
        flex: 1,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4 * SizeConfig.heightMultiplier),
          child: Row(
            children: [


              InkWell(
                onTap: () async {


                  Navigator.pushNamed(context, "/login");

                  },
                child: Text(english ? "Login"  : m["Login" ].toString(),
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),

              const Spacer(),

              InkWell(
                onTap: (){

                  Navigator.pushNamed(context, "/signup");
                } ,
                child: Text( english ? "Sign Up": m["Sign Up"].toString(),
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),


            ],
          ),
        ),
      )


    ],),


  );
}
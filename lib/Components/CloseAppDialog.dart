
import 'dart:io';

import 'package:flutter/material.dart';

import '../Config.dart';
import '../Constants.dart';
import '../string.dart';

Widget closeAppDialog(BuildContext context){


  return AlertDialog(

    elevation: 0,
    backgroundColor: Colors.transparent,

    content: Container(

      decoration: circularEdges(20, 20, 20, 20, Colors.white),
      height: SizeConfig.heightMultiplier  * 25,
      width: SizeConfig.imageSizeMultiplier * 80,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

        Container(
            margin: EdgeInsets.all(kDefaultPadding/2),
            padding: EdgeInsets.all(kDefaultPadding),

            decoration: circularEdges(15, 15, 15, 15, kBase.shade800),

            child: Column(
              children: [
                Text(english ? "Are you sure you want to exit Application?" : m["Are you sure you want to exit Application?"].toString(), style: Theme.of(context).textTheme.headline2?.copyWith(color: Colors.white),),
              ],
            )
        ),

        const Spacer(),

        Padding(
          padding: EdgeInsets.only(bottom: kDefaultPadding,right: kDefaultPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [

              InkWell(
                onTap: (){
                  Navigator.of(context).pop();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: kDefaultPadding , vertical: kDefaultPadding/5),
                  decoration: circularEdges(100, 100, 100, 100, Colors.transparent ),
                  child: Text(english ? "No" : m["No"].toString() ,
                    style: TextStyle(color: kBase,fontSize: SizeConfig.heightMultiplier * 2.5),
                  ),
                ),
              ),

              SizedBox(width: kDefaultPadding,),

              InkWell(
                onTap: (){
                  Future.delayed(const Duration(milliseconds: 200), () {
                    exit(0);
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: kDefaultPadding , vertical: kDefaultPadding/5),
                  decoration: circularEdges(100, 100, 100, 100, Colors.redAccent ),
                  child: Text(english ? "Yes" : m["Yes"].toString() ,
                    style: TextStyle(color: Colors.white,fontSize: SizeConfig.heightMultiplier * 2.5),
                  ),
                ),
              ),


          ],),
        )

      ],)

    ),

  );


}
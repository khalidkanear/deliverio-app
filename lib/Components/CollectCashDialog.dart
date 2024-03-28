import '/Components/flatTextButton.dart';
import 'package:flutter/material.dart';

import '../Config.dart';
import '../Constants.dart';

AlertDialog collectCashDialog(BuildContext context, double amount){


  TextEditingController collectedCash = TextEditingController();

  return AlertDialog(

    elevation: 0,
    insetPadding: EdgeInsets.symmetric(horizontal:SizeConfig.heightMultiplier * 2, vertical: kDefaultPadding * 2),

    backgroundColor: Colors.transparent,
    content: Container(

      height: SizeConfig.heightMultiplier * 60,
      width: SizeConfig.imageSizeMultiplier * 100,
      decoration: circularEdges(20, 20, 20, 20, kBase),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.all(kDefaultPadding*2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FittedBox(
                    child: Text("Collect Cash",
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ),
                ],),
            ),
          ),

          Expanded(
            flex: 8,
            child: Container(

              padding: EdgeInsets.all(kDefaultPadding),
              margin: EdgeInsets.all(kDefaultPadding/2),
              decoration: circularEdges(20, 20, 20, 20, Colors.white),

              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                SizedBox(
                  height: kDefaultPadding,
                ),

                Row(children: [

                  Text("To be collected", style: Theme.of(context).textTheme.headline2?.copyWith(color: Colors.black.withOpacity(.4), fontSize: SizeConfig.heightMultiplier * 2),)

                ],),

                Row(children: [

                    Text("RM $amount", style: Theme.of(context).textTheme.headline1?.copyWith(fontSize: SizeConfig.heightMultiplier * 4.5),)

                ],),

                SizedBox(height: kDefaultPadding * 3,),

                Row(children: [

                  Text("Collected Amount", style: Theme.of(context).textTheme.headline2?.copyWith(color: kBase.withOpacity(1), fontSize: SizeConfig.heightMultiplier * 2),)

                ],),


                Form(
                  child: TextFormField(
                    controller: collectedCash,
                    decoration: const InputDecoration(
                      prefixText: "RM "
                    ),
                    keyboardType: TextInputType.number,

                  ),
                ),

                SizedBox(height: kDefaultPadding,),
                FlatTextButton(context, "Collected", double.infinity, kOrange)




              ],)

            ),
          )

        ],),
    ),

  );


}
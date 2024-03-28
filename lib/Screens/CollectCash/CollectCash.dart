import '/Components/AppBar.dart';
import '/Components/flatTextButton.dart';
import 'package:flutter/material.dart';

import '../../Config.dart';
import '../../Constants.dart';





class CollectCash extends StatelessWidget {


  double amount = 40.8;

  TextEditingController collectedCash = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();


  CollectCash(){
    amount = double.parse( '$totalBill');
  }


  @override
  Widget build(BuildContext context) {



    return Scaffold(

      appBar: appBar("Collect Cash", context, kBase, Colors.white),

      body:  Container(
        width: SizeConfig.imageSizeMultiplier * 100,
        decoration: circularEdges(20, 20, 20, 20, kBase),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.all(kDefaultPadding*2),
                child: Container()
              ),
            ),

            Expanded(
              flex: 8,
              child: Container(

                  padding: EdgeInsets.all(kDefaultPadding),
                  margin: EdgeInsets.all(kDefaultPadding/2),
                  decoration: circularEdges(20, 20, 20, 20, Colors.white),

                  child: Stack(
                    children: [

                      Center(child: Icon(Icons.attach_money_rounded,color: kBase.withOpacity(.05),size: SizeConfig.heightMultiplier * 40,)),

                      Column(
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

                          const Spacer(),



                          Row(children: [

                            Text("Collected Amount", style: Theme.of(context).textTheme.headline2?.copyWith(color: kBase.withOpacity(1), fontSize: SizeConfig.heightMultiplier * 2),)

                          ],),


                          Form(
                            key: _formKey,
                            child: TextFormField(
                              controller: collectedCash,
                              decoration: const InputDecoration(
                                  prefixText: "RM "
                              ),
                              keyboardType: TextInputType.number,
                              validator: (val){
                                if(double.parse(collectedCash.text) < amount){
                                  return "Cannot be less than the amount to be Collected";
                                }

                                return null;

                              },
                            ),
                          ),

                          SizedBox(height: kDefaultPadding,),


                          InkWell(
                              onTap: ()=> cashCollected(context),
                              child: FlatTextButton(context, "Collected", double.infinity, kOrange)
                          )




                        ],),
                    ],
                  )

              ),
            )

          ],),
      ),



    );



  }


  Future<void> cashCollected(BuildContext context) async {

    if(_formKey.currentState!.validate()){






    }




  }


}

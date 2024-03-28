import '/Model/CompletedOrders.dart';
import '/Screens/OrderInitiated/Model/OrderDetailsModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Config.dart';
import '../Constants.dart';




dialogWithList(String title, List<String> list, BuildContext context,List<OrderDetails> orders){


  return AlertDialog(
    elevation: 0,
    insetPadding: EdgeInsets.symmetric(horizontal:SizeConfig.heightMultiplier * 2, vertical: kDefaultPadding * 2),
    contentPadding: const EdgeInsets.all(0),
    backgroundColor: Colors.transparent,

    content: Container(
      height: SizeConfig.heightMultiplier * 60,
      width: SizeConfig.imageSizeMultiplier * 80,
      decoration: circularEdges(20, 20, 20, 20, Colors.white),
      child: Column(children: [

        Expanded(
            flex: 2,
            child: Center(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  padding: EdgeInsets.only(left: kDefaultPadding,right: kDefaultPadding, top: kDefaultPadding/2,bottom: 0),
                  decoration: circularEdges(10, 10, 10, 10, kBase),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(title,
                        style: Theme.of(context).textTheme.headline1?.copyWith(color: Colors.white,fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                )
            )
        ),

        Expanded(
            flex: 10,
            child: Container(

              child: ListView.builder(
                  itemCount: list.length,

                  itemBuilder: (BuildContext context, int index){
                      return InkWell(
                        onTap: (){

                          Provider.of<CompletedOrdersProvider>(context,listen: false).updateList(orders, index + 1);
                          Provider.of<CompletedOrdersProvider>(context,listen: false).updateMonth(index + 1);
                          Navigator.of(context).pop();

                          },
                        child: Container(

                          padding: EdgeInsets.symmetric(horizontal: kDefaultPadding, vertical: kDefaultPadding/2),

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(list[index],
                                style: Theme.of(context).textTheme.headline2,
                              ),
                            ],
                          ),

                        ),
                      );
                  }
              ),
            )

        )


      ],),
    )


  );


}
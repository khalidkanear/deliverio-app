import '/Screens/OrderDetails/OrderDetails.dart';
import 'package:grouped_list/grouped_list.dart';
import '/Screens/OrderInitiated/Model/OrderDetailsModel.dart';
import 'package:flutter/material.dart';

import '../../../Config.dart';
import '../../../Constants.dart';
import '../../../string.dart';



class GroupedList extends StatelessWidget {


  BuildContext ?context;
  List<dynamic>? orders;


  GroupedList({
    this.context,
    this.orders
  });


  @override
  Widget build(BuildContext context) {

    return GroupedListView<dynamic, String>(
      elements: orders??[],

      groupBy: (element) => element['group'],

      groupComparator: (value1, value2) => value2.compareTo(value1),


      order: GroupedListOrder.DESC,

      useStickyGroupSeparators: true,

      groupSeparatorBuilder: (String value) {

        String ?title;

        switch(value) {

          case '1':
            title = "January";
            break;

          case '2':
            title = "February";
            break;

          case '3':
            title = "March";
            break;

          case '4':
            title = "April";
            break;

          case '5':
            title = "May";
            break;

          case '6':
            title = "June";
            break;

          case '7':
            title = "July";
            break;

          case '8':
            title = "August";
            break;

          case '9':
            title = "September";
            break;

          case '10':
            title = "October";
            break;


          case '11':
            title = "November";
            break;

          case '12':
            title = "December";
            break;

            default:

              break;
        }

        return Container(

               color: Colors.white,

               padding: const EdgeInsets.all(8.0),

               child: Text(
                 title.toString(),
                 textAlign: TextAlign.left,
                 style: TextStyle(fontSize: SizeConfig.heightMultiplier * 2.7, fontWeight: FontWeight.bold, fontFamily: "Nunito"),
               ),

       );

       },

      itemBuilder: (c, element) {

        print(element.toString());
        print(element.toString());

        OrderDetails ?order = element["order"];

        String items = "";

        for(int i = 0; i <num.parse( '${order?.orderItems?.length??0}') ; i ++){

          if(i ==int.parse('${ order?.orderItems?.length}')-1 ){
            items += '${order?.orderItems?[i].name}';
          }else{
            items += "${order?.orderItems?[i].name}, ";
          }

        }


        return Container(

          margin: EdgeInsets.all(kDefaultPadding/1.5),
          padding: EdgeInsets.all(kDefaultPadding/4),

          decoration: circularEdges(10, 10, 10, 10, kGrey),

          child: Container(

            padding: EdgeInsets.all(kDefaultPadding/1.5),

            decoration: circularEdges(10, 10, 10, 10, Colors.white),



            height: SizeConfig.heightMultiplier * 13,

            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Expanded(
                  flex: 3,
                  child: Text("#" '${order?.orderNumber}',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: SizeConfig.heightMultiplier * 2.0,
                      fontFamily: "Nunito",
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text("RM " '${order?.total}',
                    textAlign: TextAlign.end,
                    style: TextStyle(
                        fontSize: SizeConfig.heightMultiplier * 2.0,
                        fontFamily: "Nunito",
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),

              ],),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ///ORder Items String
                        ///ORder Items String
                        ///ORder Items String
                        Text( (order?.orderItems?.length == 1) ? '${order?.orderItems?.length}'  " "  + (english ? "Items" : m["Items"].toString()) : "${order?.orderItems?.length} ${english ? "Items" : m["Items"]}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: SizeConfig.heightMultiplier * 1.8,
                              fontFamily: "Nunito",
                          ),
                        ),

                        Text('${order?.timeDelivery?.split(" ")[0]}',
                          style: TextStyle(
                            color: Colors.black.withOpacity(.3),
                              fontSize: SizeConfig.heightMultiplier * 2.0,
                              fontFamily: "Nunito",
                          ),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    flex: 2,
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderDetailsScreen(orderDetails: order,)));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(english ? "Details" : m["Details"].toString(),
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: SizeConfig.heightMultiplier * 1.8,
                                fontFamily: "Nunito",
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),


                ],)

            ],),

          ),
        );

      },
    );
  }





}

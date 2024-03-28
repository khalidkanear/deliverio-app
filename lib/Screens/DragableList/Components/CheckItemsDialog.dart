import '/Components/Loading.dart';
import '/Screens/DragableList/Model/SelectedItemsListener.dart';
import '/Screens/OrderInitiated/Model/OrderItem.dart';
import '/Screens/OrderInitiated/Model/OrderStatusListener.dart';
import '/WebServices/UpdateOrderStatus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Config.dart';
import '../../../Constants.dart';
import '../../../string.dart';



Widget checkItemsDialog(BuildContext context, List<OrderItem> orders){



  List<bool> selectedProduct = [];

  List<OrderItem> products = orders;




  for (var product in products) {
    selectedProduct.add(false);
  }

  return Consumer<SelectedItem>(
    builder: (context, item,child){
      return AlertDialog(
        elevation: 0,
        insetPadding: EdgeInsets.symmetric(horizontal:SizeConfig.heightMultiplier * 2, vertical: kDefaultPadding * 2),
        contentPadding: const EdgeInsets.all(0),
        backgroundColor: Colors.transparent,
        content: Container(

          width: SizeConfig.imageSizeMultiplier * 100,
          decoration: circularEdges(20, 20, 20, 20, kBase),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.all(kDefaultPadding*2),
                  child: FittedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(english ? "CONFIRM ITEMS" : m["CONFIRM ITEMS"].toString(),
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                      ],),
                  ),
                ),
              ),

              Expanded(
                flex: 8,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: kDefaultPadding/2,vertical: kDefaultPadding/2),

                  decoration: circularEdges(0, 0, 20, 20, Colors.white),
                  child: Column(children: [
                    Expanded(

                      flex:1,
                      child: Padding(
                        padding: EdgeInsets.all(kDefaultPadding/2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 5,
                              child: Text(english ? "Product Name" : m["Product Name"].toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: SizeConfig.heightMultiplier * 1.8,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Text(english ? "Quantity" : m["Quantity"].toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: SizeConfig.heightMultiplier * 1.8,
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ),
                            Expanded(flex: 2,child: Container(),)

                          ],),
                      ),
                    ),

                    Expanded(
                      flex: 7,
                      child: Container(
                          decoration: circularEdges(20, 20, 20, 20, kGrey),
                          child: SingleChildScrollView(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: products.map((product) =>
                                    Container(
                                      margin: EdgeInsets.all(kDefaultPadding),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 4,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [

                                                Text('${product.name}',
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: SizeConfig.heightMultiplier*2,
                                                        fontFamily: 'Nunito')
                                                ),


                                              ],),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [

                                                Text("x${product.quantity}",
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: SizeConfig.heightMultiplier*2,
                                                        fontFamily: 'Nunito')
                                                ),
                                              ],),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [


                                                Checkbox(
                                                  activeColor: kOrange,
                                                  onChanged: (value){
                                                    Provider.of<SelectedItem>(context,listen: false).updateStatus(products.indexOf(product));
                                                  },
                                                  value: item.selectedItems[products.indexOf(product)],
                                                )
                                              ],),
                                          ),
                                        ],
                                      ),
                                    ),

                                ).toList()

                            ),
                          )
                      ),
                    ),

                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding:EdgeInsets.all(kDefaultPadding/3),
                            child: Row(children: [
                              Expanded(flex:5,child: Container(),),

                              Expanded(
                                flex: 4,
                                child: InkWell(
                                  onTap: (){
                                    Provider.of<SelectedItem>(context,listen: false).selectAll();
                                  },
                                  child: FittedBox(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text('${item.allSelected ?  english ? "Deselect " : m["Deselect"] :english ?  "Select All" : m["Select All"]}',
                                          style: TextStyle(
                                              fontSize: SizeConfig.heightMultiplier * 2,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ],),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: InkWell(
                                  onTap: () async {

                                    ///Loading
                                    ///Loading
                                    showDialog(
                                        context: context,
                                        builder:(BuildContext context){
                                          return loading;
                                        }
                                    );

                                    Map<String,dynamic> res = await UpdateOrderStatus(status: 1,cashCollected: false).statusUpadateReq();
                                    //Map<String,dynamic> res = {"status":200};

                                    ///Pop Loader
                                    ///Pop Loader
                                    Navigator.of(context).pop();

                                    if(res["status"]==200){
                                      
                                      SharedPreferences pref = await SharedPreferences.getInstance();
                                      
                                      pref.setString("OrderStatus", "Picked");

                                      Provider.of<OrderStatusListener>(context,listen: false).updateStatus(1);
                                      Navigator.of(context).pop();

                                    }else{
                                      Navigator.of(context).pop();
                                      ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                                          content: Text(res["response"],style: TextStyle(fontSize: SizeConfig.heightMultiplier * 2.0,),
                                          ))
                                      );

                                    }



                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text("Done",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: kBase,
                                          fontSize: SizeConfig.heightMultiplier * 2,
                                        ),
                                      ),
                                    ],),
                                ),
                              ),
                            ],),
                          ),
                        ],
                      ),
                    ),
                  ],),
                ),
              )
            ],
          ),
        ),
      );
    }
    );





}
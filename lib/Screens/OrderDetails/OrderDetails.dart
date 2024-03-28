import '/Model/ProductDetails.dart';
import '/Screens/OrderInitiated/Model/OrderDetailsModel.dart';
import 'package:flutter/material.dart';

import '../../Config.dart';
import '../../Constants.dart';
import '../../string.dart';





class OrderDetailsScreen extends StatelessWidget {


  OrderDetails? orderDetails;

  OrderDetailsScreen({
    this.orderDetails
  });

  List<ProductDetails> products = [

    ProductDetails(
        name: "SARDIN DALAM SOS TOMATO",
        sku: "MPG001-9612321312",
        store: "MyPerwajaGrocer Geliga",
        quantity: "1",
        total: "6.40"
    ),
    ProductDetails(
        name: "SARDIN DALAM SOS TOMATO",
        sku: "MPG001-9612321312",
        store: "MyPerwajaGrocer Geliga",
        quantity: "1",
        total: "6.40"
    ),ProductDetails(
        name: "SARDIN DALAM SOS TOMATO",
        sku: "MPG001-9612321312",
        store: "MyPerwajaGrocer Geliga",
        quantity: "1",
        total: "6.40"
    ),
    ProductDetails(
        name: "SARDIN DALAM SOS TOMATO",
        sku: "MPG001-9612321312",
        store: "MyPerwajaGrocer Geliga",
        quantity: "1",
        total: "6.40"
    ),ProductDetails(
        name: "SARDIN DALAM SOS TOMATO",
        sku: "MPG001-9612321312",
        store: "MyPerwajaGrocer Geliga",
        quantity: "1",
        total: "6.40"
    ),
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.black,

      body: CustomScrollView(
        slivers: <Widget>[
          // Add the app bar to the CustomScrollView.
          SliverAppBar(
            centerTitle: true,
            // Provide a standard title.
            // Allows the user to reveal the app bar if they begin scrolling
            // back up the list of items.
            floating: true,
            pinned: true,
            // Display a placeholder widget to visualize the shrinking size.
            flexibleSpace: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  child: Image.network("https://upserve.com/media/sites/2/Creative-Restaurant-Names.jpg?auto=compress",fit: BoxFit.cover,) ,
                ),

                Expanded(
                  child: Container(
                    color: Colors.black.withOpacity(.5),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                     '${orderDetails?.merchantDetails?.name}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 23,
                      ),
                    ),
                    SizedBox(height: kDefaultPadding,)
                  ],
                ),
              ],
            ),
            // Make the initial height of the SliverAppBar larger than normal.
            expandedHeight: 200,
          ),
          // Next, create a SliverList
          SliverList(
            // Use a delegate to build items as they're scrolled on screen.
            delegate: SliverChildBuilderDelegate(
              // The builder function returns a ListTile with a title that
              // displays the index of the current item.
                  (context, index) {
                return Container(

                  height: SizeConfig.heightMultiplier * 98,
                  width: SizeConfig.imageSizeMultiplier * 100,
                  decoration: circularEdges(0, 0, 20, 20, kBase),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [


                      Expanded(
                        flex: 8,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: kDefaultPadding/2,vertical: kDefaultPadding/2),

                          decoration: circularEdges(0, 0, 20, 20, Colors.white),
                          child: Column(children: [
                            Expanded(

                              flex:1,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal:kDefaultPadding, vertical: kDefaultPadding),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(english ? "Order No." : "No. Pesanan: ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: SizeConfig.heightMultiplier * 1.8,
                                      ),
                                    ),
                                    ///Reference Number
                                    ///Reference Number
                                    ///Reference Number
                                    Text("#"'${orderDetails?.refNo}',
                                      style: TextStyle(
                                        fontSize: SizeConfig.heightMultiplier * 1.8,
                                      ),
                                      textAlign: TextAlign.right,
                                    ),

                                  ],),
                              ),
                            ),

                            Expanded(
                              flex: 3,
                              child:  Padding(
                                padding: EdgeInsets.all(kDefaultPadding),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(english ? "Pickup" : "${m["Pickup"]}: ",
                                          style: TextStyle(
                                            fontFamily:"Nunito",
                                            fontWeight: FontWeight.bold,
                                            fontSize: SizeConfig.heightMultiplier * 1.8,
                                          ),
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: Icon(Icons.location_pin,color: Colors.redAccent,size: SizeConfig.heightMultiplier * 2,)),

                                        Expanded(
                                          flex: 4,
                                          child: Text(
                                           '${orderDetails?.merchantDetails?.address}',
                                            softWrap: false,
                                            overflow: TextOverflow.fade,
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                              fontFamily:"Nunito",
                                              fontSize: SizeConfig.heightMultiplier * 1.8,
                                            ),
                                          ),
                                        ),

                                      ],),

                                    ///Distance
                                    ///Distance
                                    ///Distance
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Column(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.all(SizeConfig.heightMultiplier/3,),
                                              height: SizeConfig.heightMultiplier/2,
                                              width:  SizeConfig.heightMultiplier/2,
                                              decoration: circularEdges(20, 20, 20, 20, kBase),
                                            ),
                                            Container(
                                              margin: EdgeInsets.all(SizeConfig.heightMultiplier/3,),
                                              height: SizeConfig.heightMultiplier/2,
                                              width:  SizeConfig.heightMultiplier/2,
                                              decoration: circularEdges(20, 20, 20, 20, kBase),
                                            ),
                                            SizedBox(height: kDefaultPadding/2,),
                                            Text('${orderDetails?.distance}' "km",style: TextStyle(fontSize: SizeConfig.heightMultiplier * 1.6),),
                                            SizedBox(height: kDefaultPadding/2,),
                                            Container(
                                              margin: EdgeInsets.all(SizeConfig.heightMultiplier/3,),
                                              height: SizeConfig.heightMultiplier/2,
                                              width:  SizeConfig.heightMultiplier/2,
                                              decoration: circularEdges(20, 20, 20, 20, kBase),
                                            ),
                                            Container(
                                              margin: EdgeInsets.all(SizeConfig.heightMultiplier/3,),
                                              height: SizeConfig.heightMultiplier/2,
                                              width:  SizeConfig.heightMultiplier/2,
                                              decoration: circularEdges(20, 20, 20, 20, kBase),
                                            )

                                          ],
                                        ),
                                      ],
                                    ),


                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(english ? "Delivery" : "${m["Delivery"]}: ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: SizeConfig.heightMultiplier * 1.8,
                                          ),
                                        ),
                                        Expanded( flex:1,  child: Icon(Icons.location_pin,color: Colors.blueAccent,size: SizeConfig.heightMultiplier * 2,)),
                                        Expanded(
                                          flex: 4,
                                          child: Text('${orderDetails?.customerDetails?.address}',
                                            softWrap: false,
                                            overflow: TextOverflow.fade,
                                            style: TextStyle(
                                              fontSize: SizeConfig.heightMultiplier * 1.8,
                                            ),
                                            textAlign: TextAlign.right,
                                          ),
                                        ),

                                      ],),


                                  ],),
                              ),
                            ),

                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: EdgeInsets.all(kDefaultPadding),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [

                                    Text(english ? "Order Items" : m["Order Items"].toString(),

                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: SizeConfig.heightMultiplier * 1.8,
                                      ),

                                    ),

                                    Text(english ? "Total" : m["Total"].toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: SizeConfig.heightMultiplier * 1.8,
                                      ),
                                      textAlign: TextAlign.right,
                                    ),

                                  ],),
                              ),
                            ),

                            Expanded(
                              flex: 4,
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: kDefaultPadding/2),
                                padding: const EdgeInsets.symmetric(vertical: 2),
                                  decoration: circularEdges(20, 20, 20, 20, kGrey),
                                  child: SingleChildScrollView(
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: orderDetails?.orderItems?.map((product) =>
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
                                                                fontSize: SizeConfig.heightMultiplier * 1.8,
                                                                fontFamily: 'Nunito')
                                                        ),

                                                        Text("SKU: "'${product.sku}',style: Theme.of(context).textTheme.headline3,),

                                                        Text("Store: "'${product.store}',style: Theme.of(context).textTheme.headline3,),
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

                                                        Text("RM",
                                                            style: TextStyle(
                                                                fontWeight: FontWeight.bold,
                                                                fontSize: SizeConfig.heightMultiplier*1.8,
                                                                fontFamily: 'Nunito')
                                                        ),
                                                        Text(product.price.toString(),
                                                            style: TextStyle(
                                                                fontWeight: FontWeight.bold,
                                                                fontSize: SizeConfig.heightMultiplier*1.8,
                                                                fontFamily: 'Nunito')
                                                        ),
                                                      ],),
                                                  ),
                                                ],
                                              ),
                                            ),

                                        ) as List<Widget>,

                                    ),
                                  )
                              ),
                            ),

                            Expanded(
                              flex: 2,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding:EdgeInsets.all(kDefaultPadding),
                                    child: Row(children: [
                                      Expanded(
                                        flex: 5,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Text(english ? "Delivery Charges:" : "Caj Penghantaran:",
                                              style: TextStyle(
                                                  fontSize: SizeConfig.heightMultiplier * 2,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),
                                          ],),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Text("RM 0.0",
                                              style: TextStyle(
                                                fontSize: SizeConfig.heightMultiplier * 2,
                                              ),
                                            ),
                                          ],),
                                      ),
                                    ],),
                                  ),

                                  Padding(
                                    padding:EdgeInsets.all(kDefaultPadding),
                                    child: Row(children: [
                                      Expanded(
                                        flex: 5,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Text(english ? "Grand Total:" : "Jamula Keseluruhan:",
                                              style: TextStyle(
                                                  fontSize: SizeConfig.heightMultiplier * 2,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),
                                          ],),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Text("RM ${orderDetails?.total}",
                                              style: TextStyle(
                                                fontSize: SizeConfig.heightMultiplier * 2,
                                              ),
                                              textAlign: TextAlign.right,
                                            ),
                                          ],),
                                      ),


                                    ],),
                                  ),

                                ],
                              ),
                            ),
                            Expanded(flex: 3,child: Container(),)
                          ],),
                        ),
                      )

                    ],),
                );

                  },
              // Builds 1000 ListTiles
              childCount: 1,
            ),
          ),
        ],
      ),



    );
  }
}

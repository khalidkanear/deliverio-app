import '/Config.dart';
import '/Constants.dart';
import 'package:flutter/material.dart';


class Terms extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: const Text("Privacy Policy"),
        elevation: 0,iconTheme: const IconThemeData(color: Colors.white),),
      body: Padding(
        padding: EdgeInsets.all(kDefaultPadding),
        child: Column(children: <Widget>[

          Expanded(
            flex: 10,
            child: Container(
              decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.white
              ),


              child: SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.all(kDefaultPadding),
                    child: Text(
                      kTermsAndConditions,
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontSize: SizeConfig.heightMultiplier * 2),)

                ),
              ),

            ),
          )


        ],),
      ),

    );


  }


}
